#import "@preview/cetz:0.5.2"

// #set page(width: auto, height: auto, margin: 5mm)
#set page(paper: "a5", margin: 5mm)
#set align(center + horizon)
#set math.mat(delim: "[")





$ mat( - sin("az"), cos("az"), 0; 
- cos("az") * sin("el"), - sin("az") * sin("el"), cos("el");) vec(x,y,z) = vec("screen_x", "screen_y", ) $

#cetz.canvas(length: 10mm, {
  import cetz.draw: *

  // pgfplots default 3D view (azimuth 25 deg, elevation 30 deg) to match the original:
  // screen_x = -x sin(az) + y cos(az);
  // screen_y = -(x cos(az) + y sin(az)) sin(el) + z cos(el)

  let az = 25deg
  let el = 30deg

  let az-sin = calc.sin(az)
  let az-cos = calc.cos(az)

  let el-sin = calc.sin(el)
  let el-cos = calc.cos(el)

  let az-cos-el-sin = az-cos * el-sin
  let az-sin-el-sin = az-sin * el-sin

  set-transform((
    (az-sin, - az-cos, 0, 0),
    (- az-cos-el-sin, - az-sin-el-sin, el-cos, 0),
    (0, 0, 1, 0),
    (0, 0, 0, 1),
  ))
  
  // set-transform((
  //   (0.4226, -0.9063, 0, 0),
  //   (-0.4532, -0.2113, 0.8660, 0),
  //   (0, 0, 1, 0),
  //   (0, 0, 0, 1),
  // ))

  line(
    (0, 0, 0),
    (3, 0, 0),
    stroke: (thickness: 1pt, paint: red),
    mark: (end: "stealth", fill: red, scale: 0.5),
    name: "x",
  )
  line(
    (0, 0, 0),
    (0, 3, 0),
    stroke: (thickness: 1pt, paint: green),
    mark: (end: "stealth", fill: green, scale: 0.5),
    name: "y",
  )
  line(
    (0, 0, 0),
    (0, 0, 3),
    stroke: (thickness: 1pt, paint: blue),
    mark: (end: "stealth", fill: blue, scale: 0.5),
    name: "z",
  )
  content((rel: (0.2, 0, 0), to: "x.end"), [#set text(fill: red); $x$])
  content((rel: (0, 0.2, 0), to: "y.end"), [#set text(fill: green); $y$])
  content((rel: (0, 0, 0.2), to: "z.end"), [#set text(fill: blue); $z$])


})
