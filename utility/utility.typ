#import calc: *
#import "@preview/cetz:0.5.2": canvas, draw, vector, angle
#import draw: *
#import vector: *

#let draw-cartesion(
  xl: 3cm,
  yl: 3cm,
  zl: 3cm,
  xcolor: red,
  ycolor: green,
  zcolor: blue,
  t: 1pt,
  dash: "solid",
  s: 0.9,
) = {
  line(
    (0, 0, 0),
    (xl, 0, 0),
    stroke: (thickness: t, paint: xcolor, dash: dash),
    mark: (end: "stealth", fill: xcolor, scale: s),
    name: "x",
  )

  line(
    (0, 0, 0),
    (0, yl, 0),
    stroke: (thickness: t, paint: ycolor, dash: dash),
    mark: (end: "stealth", fill: ycolor, scale: s),
    name: "y",
  )

  line(
    (0, 0, 0),
    (0, 0, zl),
    stroke: (thickness: t, paint: zcolor, dash: dash),
    mark: (end: "stealth", fill: zcolor, scale: s),
    name: "z",
  )

  content((rel: (0.2, 0, 0), to: "x.end"), [#set text(fill: xcolor); $x$])
  content((rel: (0, 0.2, 0), to: "y.end"), [#set text(fill: ycolor); $y$])
  content((rel: (0, 0, 0.2), to: "z.end"), [#set text(fill: zcolor); $z$])
}



#let sph(r, theta, phi) = {
  let x = r * sin(theta) * cos(phi)
  let y = r * sin(theta) * sin(phi)
  let z = r * cos(theta)
  return (x, y, z)
}


#let draw-sphere(
  r: 3,
  theta-num: 30,
  phi-num: 30,
  fill: rgb("#dadada25"),
  stroke: rgb("#ffffff2b"),
  plight: (6, 6, 6),
  pintensity: 0.5,
  aintensity: 0.5,
) = {
  for i in range(theta-num) {
    for j in range(phi-num) {
      let theta-step = pi / theta-num
      let theta-curr = i * theta-step
      let theta-next = (i + 1) * theta-step

      let phi-step = 2 * pi / phi-num
      let phi-curr = j * phi-step
      let phi-next = (j + 1) * phi-step
      
      let Pa = sph(r, theta-curr, phi-curr)
      let Pb = sph(r, theta-curr, phi-next)
      let Pc = sph(r, theta-next, phi-next)
      let Pd = sph(r, theta-next, phi-curr)

      let normalize-of-rect = norm(add(Pa, Pc))
      let normalize-of-Plight = norm(plight)
      let P-Diffuse = max(0, dot(normalize-of-rect, normalize-of-Plight))

      let intensity = min(1, pintensity * P-Diffuse + aintensity)

      let fill-darken = { fill.darken(100% * (1 - intensity)) }

      line(
        Pa,
        Pb,
        Pc,
        Pd,
        close: true,
        mark: none,
        fill: fill-darken,
        stroke: stroke,
      )
    }
  }
}
