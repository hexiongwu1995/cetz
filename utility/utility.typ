#import calc: *
#import "@preview/cetz:0.5.2": angle, canvas, draw, vector
#import draw: content, line, ortho
#import vector: add, dot, norm

#let draw-cartesian(
  xl: 3cm,
  yl: 3cm,
  zl: 3cm,
  xcolor: red,
  ycolor: green,
  zcolor: blue,
  t: 1pt,
  dash: "solid",
  s: 0.9,
  draw-angle: true,
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

  // draw the angle between x and y axes
  if draw-angle {
    angle.angle(
      "x.start",
      "x.end",
      "y.end",
      label: $alpha$,
      mark: (end: ">", fill: black, scale: 0.5),
      stroke: (dash: "dashed"),
      radius: xl / 2,
      direction: "ccw",
    )
  }

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
  pintensity: 0.3,
  aintensity: 0.7,
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


#let draw-cube(
  point: (0, 0, 0),
  xl: 6,
  yl: 6,
  zl: 6,
  xcolor: rgb("#fc00000f"),
  ycolor: rgb("#77ff000e"),
  zcolor: rgb("#006dfb13"),
  neutral-color: rgb("#ffffff23"),
  stroke: rgb("#cfcfcf5e") + 1pt,
  t: 1pt,
  dash: "solid",
  s: 0.9,
) = {
  let (px, py, pz) = point
  // draw the xy plane at z = - zl / 2
  line(
    (px - xl / 2, py - yl / 2, -zl / 2),
    (px - xl / 2, py + yl / 2, -zl / 2),
    (px + xl / 2, py + yl / 2, -zl / 2),
    (px + xl / 2, py - yl / 2, -zl / 2),
    close: true,
    fill: neutral-color,
    stroke: stroke,
  )
  // draw the xy plane at z = zl / 2
  line(
    (px - xl / 2, py - yl / 2, zl / 2),
    (px - xl / 2, py + yl / 2, zl / 2),
    (px + xl / 2, py + yl / 2, zl / 2),
    (px + xl / 2, py - yl / 2, zl / 2),
    close: true,
    fill: zcolor,
    stroke: stroke,
  )

  // draw the xz plane at y = - yl / 2
  line(
    (px - xl / 2, -yl / 2, pz - zl / 2),
    (px - xl / 2, -yl / 2, pz + zl / 2),
    (px + xl / 2, -yl / 2, pz + zl / 2),
    (px + xl / 2, -yl / 2, pz - zl / 2),
    close: true,
    fill: neutral-color,
    stroke: stroke,
  )
  // draw the xz plane at y = yl / 2
  line(
    (px - xl / 2, yl / 2, pz - zl / 2),
    (px - xl / 2, yl / 2, pz + zl / 2),
    (px + xl / 2, yl / 2, pz + zl / 2),
    (px + xl / 2, yl / 2, pz - zl / 2),
    close: true,
    fill: ycolor,
    stroke: stroke,
  )

  // draw the yz plane at x = - xl / 2
  line(
    (-xl / 2, py - yl / 2, pz - zl / 2),
    (-xl / 2, py - yl / 2, pz + zl / 2),
    (-xl / 2, py + yl / 2, pz + zl / 2),
    (-xl / 2, py + yl / 2, pz - zl / 2),
    close: true,
    fill: neutral-color,
    stroke: stroke,
  )
  // draw the yz plane at x = xl / 2
  line(
    (xl / 2, py - yl / 2, pz - zl / 2),
    (xl / 2, py - yl / 2, pz + zl / 2),
    (xl / 2, py + yl / 2, pz + zl / 2),
    (xl / 2, py + yl / 2, pz - zl / 2),
    close: true,
    fill: xcolor,
    stroke: stroke,
  )
}
