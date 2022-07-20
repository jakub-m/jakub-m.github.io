---
layout: post
title:  "User settings, Lamport clocks and lightweight formal methods"
date:   2022-07-17 21:46:39 -0000

---

Synchronizing settings between browsers and a backend seems a simple task. It turns out that it can teach us some
lessons on distributes systems and formal modeling.  After you read this post, you will learn, I hope, how we used
[Lamport Clocks][ref_fowler] to synchronize user settings between browsers and backend service. You will also learn
how we used [Lightweight Formal Methods][ref_light_formal] to find bugs in our implementation of the synchronization
protocol.

At [Airspace Intelligence][ref_asi] we work on products supporting airlines' operations. One of the products we are
building is an application for messaging between the dispatchers (the ground staff coordinating the carriers'
aircrafts), and the pilots (the folks driving the planes). Think of WhatsApp for airplanes.

The application, or just the App, integrates with the [existing airline's systems][ref_acars].  The App delivers slick
browser UI, and at the same time needs to communicate with the existing notification systems to notify that the
dispatcher has a new message from the pilot. The "existing notification systems" are not browser-based, so even though
the messaging itself happens in the browser, the notification flow happens outside of the browser. Think of
push notifications that are delivered to a device outside browser. To deliver messages to proper users (e.g. all the
dispatchers interested in flights departing from Seattle), the backend service relies on the user settings to figure
out which user (dispatcher) should be notified about which message. Different dispatchers handle a different set of flights.

It is important that the browsers serving the App, connected to the backend, and the backend itself, have a consistent
view on the user settings,  so the backend can reliably trigger send notifications to the dispatchers about pending
messages. The case we especially want to avoid is that the browsers "see" different settings than the backed, or that
the settings between the browsers and the backend don't converge. At the same time, we want to provide a snappy
experience, when the dispatcher can select different settings (different flight selectors), and the settings won't
flicker as the requests and responses go back and forth between the browser and the backend.

# But that's trivial, right?

Superficially yes. But if you want to be _sure_ that the settings are synchronized correctly, avoid weird edge cases
and still provide a snappy experience, you need to take extra care.

With two browsers and a single backend (single storage), different things can happen. A user can click settings in one
browser, and then different settings in another one. There can be transient network problems so the browsers fail to
send the up-to-date settings to the backend. The user can click back and forth the settings several times, or restart the
browser. 

The simplest thing to do would be to send the settings with each click. The problem is that if you clicked different
settings fast, or when the network is slow, it could happen that you changed some setting A and then a different
settings B, but after you clicked B your browser received a response from the backend for "A" change. The "A response"
would overwrite the "B" change in the browser, causing the settings to flicker. Alternatively, you could wait for a response
after each request, but then the experience wouldn't be "snappy".

Also, what if your request never reached the backend service?  Aha, you say, let's add a periodic sync job in the
browser to synchronize the state of the browser with the backend. This would also protect us from the case when someone
changed settings in a different browser window. This would work, but you need to figure which settings are the "current"
ones, the ones in the browser or the ones on the backend. Easy, just add a clock. But now how can you be _sure_ that the
clock is right? It should, [but what if not][ref_amadeus]? How can you reliably [compare the clocks][ref_sokocheff]?
Folk wisdom says to never trust external clocks.

You could add some integer that you increment every time you synchronize or change state, and choose the larger one...
Wait, sounds like you are inventing the...

# Lamport Clocks

The idea is straightforward: make each process measure its own time, and synchronize the time when the processes
(browsers and the backend) exchange events.  

Events make the time "tick". When an event, like a change in the settings, happens, a process increments its local time
(an integer). When the processes exchange the information, they pass the counter along, compare the received counter
with the local counter, choose the larger one (local or received) together with the accompanying state (i.e. the
settings), _and increment the local clock by 1_. Mr. Lamport showed that such clocks allow reasoning about the [ordering
of the events][ref_wiki].

Each time the user clicks the settings, the Lamport clock (a local integer) in the browser increments by 1. The settings
are sent from the browsers to the backend, and the "larger clock wins". Eventually, all the browsers and the backend
should converge to the same values... At least that's what we thought.

# Lightweight formal methods

Testing a distributed system, even as simple as the above, is difficult. There are [dedicated frameworks and languages,
like TLA+][ref_tlaplus] for that purpose. While expressive and battle-proven, a "test", or specification, written in
TLA+ would be doomed to become instantly unmaintained.  Instead, we adopted "Property-based testing" described in the
[Lightweight Formal Methods][ref_light_formal] paper.  In a nutshell, the idea is that you implement simple reference
models, then randomly generate sets of events, and check if after running the events on the reference models the
properties of the system hold. Such "lightweight formal tests" are a part of the regular unit-test suite, together with
the other tests.

In our case, a "reference model" for a browser app was merely a class with two fields - "settings" and "Lamport clock".
The backend service used in the tests was the _actual_ backend service running locally as a part of the unit test setup.

The events generated were:

1. The user changed settings in the app and the app sent the up-to-date settings to the backend.
2. The user changed settings but the browser did not send the up-to-date settings to the backend (e.g. because of
the connectivity issues).
3. The browser synchronizes with the backend.
4. The browser resets.

What we tested for was the property: after a random set of events and two synchronization rounds between the browsers
and the backend, all the browsers and the backend had the same settings. We used "two synchronization rounds" as it
turned out that one synchronization round is not enough for convergence.

# The bug

So we run the test with thousands and thousands of sequences of events, and, to our surprise, the tests failed! There
was a sequence of events that caused the system to not converge to a single state. It turned out that 
the state would not converge when all of the browsers and the backend had different settings but the same values of Lamport
clocks. Consider the following sequence:

1. Initial state.
  - browser: settings: none, clock: 0
  - backend: settings: none, clock: 0

2. The user changes settings in the browser, and the browser synchronizes the settings with the backend. The clock for
browser is 3: just after the settings change, locally the clock increments to 1, is sent to the backend, the backend
increments the clock to 2, and sends it to the browser where it is yet again incremented to 3.
  - browser: settings: foo, clock: 3
  - backend: settings: foo, clock: 2

3. The browser resets, all the state is dropped.
  - browser: settings: none, clock: 0
  - backend: settings: foo, clock: 2

4. The user changes the settings twice, but this time the state is not propagated to the backend (e.g. due to network
hiccups).
  - browser: settings: none, clock: 2
  - backend: settings: foo, clock: 2

Now, if left like that, the state would never converge between the browser and the backend. Both ends have the same clock
value and cannot decide on the order of the events. Rare? Yes, rare. Correct? Definitely not!

The fix was to break the tie by incrementing the clock on the backend side whenever comes a request with the equal clock.
Intuitively, one can argue that something might have happened on the backend side meanwhile, e.g. settings changed to
some value and changed back to the original value, leaving the settings unchanged but the clock incremented. With the
above example, when the backend received an event with the browser clock value equal to the backend's local clock value,
the backend would silently increment its clock and return it to the browser:

{:start="5"}
5. Backend increments its clock on an equal input clock.
  - browser: settings: none, clock: 4
  - backend: settings: foo, clock: 3

After the change, the test didn't fail anymore.

# Conclusions

Handling even a simple distributed state is not trivial if one wants to do it correctly. Fortunately, algorithms and rich
research exist. Lightweight formal testing is a very _practical_ framework for testing such algorithms in the
application context.

([on HN][ref_hn])

[ref_acars]:https://en.wikipedia.org/wiki/ACARS
[ref_amadeus]:https://phys.org/news/2012-07-wreaks-internet-havoc.html
[ref_asi]:https://www.airspace-intelligence.com/company
[ref_fowler]:https://martinfowler.com/articles/patterns-of-distributed-systems/lamport-clock.html
[ref_light_formal]:https://dl.acm.org/doi/10.1145/3477132.3483540
[ref_sokocheff]:https://sookocheff.com/post/time/lamport-clock/
[ref_tlaplus]:https://en.wikipedia.org/wiki/TLA%2B
[ref_wiki]:https://en.wikipedia.org/wiki/Lamport_timestamp
[ref_hn]:https://news.ycombinator.com/item?id=32171619
