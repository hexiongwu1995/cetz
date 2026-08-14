// Empty .typ file

#set page(paper: "a5", flipped: true, margin: 1cm)
#set align(center + horizon)

#import "@preview/cetz:0.5.2"
#cetz.canvas({
  import cetz.draw: *
  import cetz.angle: *
  import calc: *
  import cetz.util.vector

  let sph(r, theta, phi) = {
    let x = r * sin(theta) * cos(phi)
    let y = r * sin(theta) * sin(phi)
    let z = r * cos(theta)
    return (x, y, z)
  }

  let mark-axis = (end: (symbol: "stealth", fill: black, scale: 0.5))
  let stroke-axis = (dash: "dotted")


  ortho(x: 15deg, y: 10deg, z: 0deg, sorted: false, {
    on-zy(x: -2.5, circle((0, 0), radius: calc.sqrt(9 - calc.pow(-2.5, 2)), fill: red.transparentize(70%), stroke: (paint: red, thickness:1mm)))
    on-zy(x: -2.5, circle((0, 0), radius: 0.05, fill: black, stroke: none))
    line((-2.5, 0, 0), (0, 0, 0), stroke:stroke-axis)
    // on-zy(x: -2.3, circle((0, 0), radius: calc.sqrt(9 - calc.pow(-2.3, 2)), fill: red.transparentize(70%), stroke: red))
    // on-zy(x: -2.3, circle((0, 0), radius: 0.05, fill: black, stroke: none))



    let Draw-Sphere(
      R: 3.05,
      Theta-num: 50,
      Phi-num: 50,
      Fill: rgb("#07b2e1"),
      Plight: (6, 6, 6),
      Pintensity: 0.5,
      Aintensity: 0.5,
    ) = {
      line((0, 0, 0), (3 * R, 0, 0), name: "x", stroke: stroke-axis, mark: mark-axis)
      line((0, 0, 0), (0, R, 0), name: "y", stroke: stroke-axis, mark: mark-axis)
      line((0, 0, 0), (0, 0, R), name: "z", stroke: stroke-axis, mark: mark-axis)
      content((rel: (0.4, 0, 0), to: "x.end"), $x$)
      content((rel: (0, 0.4, 0), to: "y.end"), $y$)
      content((rel: (0, 0, 0.4), to: "z.end"), $z$)

      let Get-Coords(R, Theta, Phi) = {
        let x = R * sin(Theta) * cos(Phi)
        let y = R * sin(Theta) * sin(Phi)
        let z = R * cos(Theta)
        return (x, y, z)
      }

      for i in range(Theta-num) {
        for j in range(Phi-num) {
          let Theta-step = pi / Theta-num
          let Theta-curr = i * Theta-step
          let Theta-next = (i + 1) * Theta-step

          let Phi-step = 2 * pi / Phi-num
          let Phi-curr = j * Phi-step
          let Phi-next = (j + 1) * Phi-step

          let Pa = Get-Coords(R, Theta-curr, Phi-curr)
          let Pb = Get-Coords(R, Theta-curr, Phi-next)
          let Pc = Get-Coords(R, Theta-next, Phi-next)
          let Pd = Get-Coords(R, Theta-next, Phi-curr)

          let normalize-of-rect = vector.norm(vector.add(Pa, Pc))
          let normalize-of-Plight = vector.norm(Plight)
          let P-Diffuse = max(0, vector.dot(normalize-of-rect, normalize-of-Plight))

          let Intensity = min(1, Pintensity * P-Diffuse + Aintensity)

          let Fill-darken = { Fill.darken(100% * (1 - Intensity)) }

          //
          line(Pa, Pb, Pc, Pd, close: true, mark: none, fill: Fill-darken.transparentize(70%), stroke: none)
        }
      }
    }

    Draw-Sphere()

  })
})

