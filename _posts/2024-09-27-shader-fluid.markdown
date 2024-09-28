---
layout: post
title: "\"Shader fluid\" - Navier-Stokes in WebGL"
date: 2024-09-27 00:00:00 -0000
permalink: shader-fluid-post

---

This is my take on implementing fluid in WebGL. It's a direct implementation of
["Real-Time Fluid Dynamics for Games" from Jos Stam][ref_paper]. The
computation is done entirely with shaders, with textures as input and output
matrices.

The [**web app is here**][ref_app]. Works better on Chrome than on Firefox.

The [source code is here][ref_code], together with plenty of useful links, and
my naive understanding of WebGL pipeline.


My implementation is buggy, I think it does not conserve mass or energy in the
system.

[ref_code]:https://github.com/jakub-m/navier-stokes-webgl-shaders
[ref_app]:https://jakub-m.github.io/shader-fluid-app
[ref_paper]:https://web.archive.org/web/20200805215025/https://pdfs.semanticscholar.org/847f/819a4ea14bd789aca8bc88e85e906cfc657c.pdf
