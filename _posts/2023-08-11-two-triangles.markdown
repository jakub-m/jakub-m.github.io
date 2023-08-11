---
layout: post
title: "Technical Triangle and Domain Triangle"
date: 2023-08-11 00:00:00 -0000
---

You are an Engineer and you talk with your Product Manager and the Business
People. You explain to them how important it is to migrate the database to the
new schema, but they just don’t get it. Not only they don’t get it, but they
say that it’s more important to at this new button in the UI to sort the users
by the last activity time. They say it’s a “tremendous added value” and “a game
changer”, and you know it’s just a one-afternoon fix in React. They don’t seem
to get, that the database problem is clearly more important and definitely
larger in scope. And this UI guy will, again, take all the praises for adding
the damn button!

For sure something just happened. There are two competent and good-willing
folks “that just don’t get it”. There is some miscommunication going on. I have
a small theory of what’s happening there…

Enter **The Theory of Two Triangles**.

Draw two triangles, one with the base to the bottom, and the second one, with
the base to the top. The triangles are side-by-side, their heights do not
overlap. The first triangle is a **Technical Triangle**, the second is a **Domain
Triangle**.

![triangles](/assets/triangles/triangles_levels.png)

The **Technical Triangle** is an analogy of how much effort does it require to
build a functionality. The wide base is all the infrastructure, or libraries,
OS, or commodity services (e.g. hosting, CDN, metrics). As the triangle goes up
there is less effort you need to build more. The middle of the triangle could
be the backend (you program in a high-level language like Python or Java and
can have a fair backend in a couple of days). The top of the triangle would be
the front-end (a simple React with CSS giving you a visually appealing
interactive experience). Yes, I am oversimplifying, it’s just a triangle after
all.

The **Domain Triangle** is the other way around. The width of the domain
triangle stands for the added value of the product. The narrow bottom is the
very first basic feature of your product. As the user base grows and you learn
the market and the user needs, you add more features on top of the other
features. The initial disjoint features add more value in synergy when suddenly
you can use features X, Y, and Z in all the products A, B, and C. For example
when you can embed Excel spreadsheets into Word documents, or you can embed
YouTube videos into Gmail emails.

This framework is useful in different areas.

# Career - how you operate within the company

At your workplace, you operate at some level of those triangles. You might
operate near the wider base of the technical triangle, working in the SRE or
infrastructure team, providing commodity computation, databases, and the build
system for the rest of the organization, or working on security. All the other
developers in the company will use your platform to deliver their work.

You might operate somewhere in the middle of the triangles, working on a
backend, where you join some of the business domain knowledge (domain entities
and state) together with generic systems knowledge (availability, scalability).

You can operate near the top of the triangles, e.g. on the UI of the product,
where you translate the deep business context of how the customers would use
the application into the actual implementation.

Finally, you can operate at the very top of the business triangle, disjoint
from the technical triangle, conceptualizing the products for which there is no
backing technical part yet.

The two triangles are helpful to **position yourself** where are you in this
framework, where are you in the company, and where you want to be (more of a
generalist or more of a domain expert). It also helps to realize that to be a
successful UI / UX developer, you can’t escape from diving into the domain that
you develop the UI for.

# Planning, priorities, contractors

You fight for closing a deal with a potential customer. Your core service has
two problems that can nuke the deal: accuracy of the data that will be provided
to the customer, and stability (uptime) of the service. Your development
resources are limited and you need to prioritize.

![img](/assets/triangles/triangles_outsourcing.png)

The Triangles can be helpful here. You see that to address stability you need
no domain knowledge, and to address data accuracy you need domain knowledge.
You will want then to use your in-house developers to work on accuracy because
improving the accuracy of the data requires domain expertise. On the other
hand, you can use external contractors to work on system stability because that
work requires generic technical knowledge (e.g. how to scale the services or
how to apply the redundancy).

# Credit and recognition

When you launch a new product or a new feature, it will happen that the folks
close to the base of Technical Triangle will be credited less than those closer
to the Domain Triangle (the product designer or the UI devs). While you
probably don’t want to credit Guido van Rossum every time you deliver a feature
in Python, you definitely want to credit the folks that helped tune the
database, helped set the load balancers, or had a close look at security.

# Communication across the Triangles

When communicating, mind where on the technical—domain spectrum are you and
where your audience is. A common mistake is that an IC developer communicates
with less technical domain experts (e.g. the management) and describes issues
with very technical terms, irrelevant to the domain. Such an IC answering the
question “What was the impact of issue X” might focus on describing technical
A, B, and C, while what is important for the business is the impact on the
domain (the customers, the operations).

# Remark on the career ladder

The career ladder does not necessarily go from the Technical Triangle up to the
Domain Triangle. It is not necessarily the case that a great IC must become a
technical-agnostic domain expert to advance in a company — one might become a
domain-agnostic Principal Engineer working on a generic computing platform. A
company though will want to promote more the IC that have a certain level of
domain expertise, because such ICs can do better decisions without a single
domain expert telling them what to do.

# Conclusion

I showed you a simple framework that you can use to think of or discuss
different company issues. While I am definitely biased, I see this framework
increasingly useful.
