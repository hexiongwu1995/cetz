#import "./utility/utility.typ": *


#set page(paper: "a5", margin: 5mm)
#set align(center + horizon)


#canvas({
  import draw: *

  perspective(x: -70deg, y: 0deg, z: -100deg, sorted: false, {
    let r = 3
    draw-cartesion(xl: 4, yl: 6, zl: 4, xcolor: black, ycolor: black, zcolor: black, dash: "solid")

    {
      let py = -2.5
      on-xz(
        y: py,
        circle((0, 0), radius: sqrt(9 - pow(py, 2)), fill: red.transparentize(70%), stroke: (
          paint: red,
          thickness: 1mm,
        )),
      )
      on-xz(y: py, circle((0, 0), radius: 0.05, fill: black, stroke: none))
      line((0, py, 0), (0, 0, 0), stroke: (dash: "dashed"))
    }

    draw-sphere(r: r + 0.05, stroke: rgb("#ffffff11"))
  })
})
