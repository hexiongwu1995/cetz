// Empty .typ file
#import "@preview/cetz:0.5.2"
#import "@preview/numty:0.1.0" as nt

// #set page(width: auto, height: auto, margin: 5mm)
#set page(paper: "a5", margin: 5mm)
#set align(center + horizon)
#set math.mat(delim: "[")

#let alpha = calc.pi / 4
#let betta = calc.pi / 4
#let gamma = calc.pi / 4

#let transform-y = (
  (calc.cos(betta), 0, -calc.sin(betta), 0),
  (0, 1, 0, 0),
  (calc.sin(betta), 0, calc.cos(betta), 0),
  (0, 0, 0, 1),
)

#let transform-z = (
  (calc.cos(gamma), -calc.sin(gamma), 0, 0),
  (calc.sin(gamma), calc.cos(gamma), 0, 0),
  (0, 0, 1, 0),
  (0, 0, 0, 1),
)

#let transform-composition = nt.matmul(transform-z, transform-y)


#cetz.canvas(length: 10mm, {
  import cetz.draw: *
  set-transform(transform-y)
  // set-transform(transform-composition)


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
