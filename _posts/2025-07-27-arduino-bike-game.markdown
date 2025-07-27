---
layout: post
title: Arduino Rust reflex game with bike power plant
date:  2025-07-27  00:00:01 -0000
permalink: arduino-reflex-game
---

With two friends we worked on a bike "power plant" that would power USB
charger and a "reflex game" (based on Arduino Uno), for our local primary
school.

[Rust source code for Arduino Uno][1].

[1]: https://github.com/jakub-m/arduino-uno-rust-reflex-game

Started with detailed schemas:

  <a href="assets/arduino-bike/10_schema.jpeg">
    <img src="assets/arduino-bike/10_schema.jpeg" width="300em" />
  </a>

  <a href="assets/arduino-bike/11_schema.jpeg">
    <img src="assets/arduino-bike/11_schema.jpeg" width="300em" />
  </a>

A custom build Arduino shield. It was needed to drive the button LEDs from the
shift register:

  <a href="assets/arduino-bike/20_arduino_shield.jpeg">
    <img src="assets/arduino-bike/20_arduino_shield.jpeg" width="300em" />
  </a>

Assembled electronics:

  <a href="assets/arduino-bike/30_game_assembled.jpeg">
    <img src="assets/arduino-bike/30_game_assembled.jpeg" width="300em" />
  </a>

A bike with a "power plant" made out of a DC engine. We first tried with a car
alternator but it was extremely hard to spin when the voltage regulator kicked
in:

  <a href="assets/arduino-bike/33_bike.jpeg">
    <img src="assets/arduino-bike/33_bike.jpeg" width="300em" />
  </a>

Power plant working:

  <video width="300em" controls>
    <source src="assets/arduino-bike/35_power_plant.mov" type="video/quicktime">
    Your browser does not support the video tag.
    </source>
  </video>

The game:

  <video width="300em" controls>
    <source src="assets/arduino-bike/40_game_only.mov" type="video/quicktime">
    Your browser does not support the video tag.
    </source>
  </video>

Game and bike at work:

  <video width="300em" controls>
    <source src="assets/arduino-bike/50_full_setup.mov" type="video/quicktime">
    Your browser does not support the video tag.
    </source>
  </video>

And deployed:

  <a href="assets/arduino-bike/55_deployed.jpeg">
    <img src="assets/arduino-bike/55_deployed.jpeg" width="300em" />
  </a>

