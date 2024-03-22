# 05 - Parallax

Create, using JavaScript, a scene that looks like the following:

> https://www.youtube.com/watch?v=oE2ZVhHwxAU

Notes:
- Parralax is a result of sidways strafing where objects that are closer appear to move more quickly than objects that are far away.
- Closer objects appear larger than objects that are far away.

Therefore:
- If a pixel object is closer, meaning larger, it should move faster, meaing there is a proportional, probably linear, relationship between object size and speed.

So instead of just populating a series of `ctx.fillRect`, what I actually want to do is create a pixel object just off the canvas, then have it scroll left at a speed relative to its size.

- create pixel of size*size at 640px from the left with a random height between 0-360
- every cycle, update the horizontal position of the pixel
  - basically give it a leftward velocity based on size
