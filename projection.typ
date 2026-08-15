
#import "utility/utility.typ": *

#set page(paper: "a5")

#grid(
  columns: (1fr, 1fr),
  rows: auto,
  gutter: 5mm,
  canvas({
    // import draw: *
    ortho(x: 0deg, y: 0deg, z: 0deg, {
      draw-cartesian(xl: 2, yl: 2, zl: 2, dash: "dashed")
      draw-cube(xl: 4, yl: 4, zl: 4)
      content((0, -2.2, 0), text(size: 8pt)[ortho(x: 0deg, y: 0deg, z: 0deg)])
    })
  }),

  canvas({
    // import draw: *
    ortho(x: -90deg, y: 0deg, z: 0deg, {
      draw-cartesian(xl: 2, yl: 2, zl: 2, dash: "dashed")
      draw-cube(xl: 4, yl: 4, zl: 4)
      content((0, 0, -2.2), text(size: 8pt)[ortho(x: -90deg, y: 0deg, z: 0deg)])
    })
  }),

  canvas({
    // import draw: *
    ortho(x: -70deg, y: 0deg, z: -120deg, {
      draw-cartesian(xl: 2, yl: 2, zl: 2, dash: "dashed")
      draw-cube(xl: 4, yl: 4, zl: 4)
      content((0, 0, -3.2), text(size: 8pt)[ortho(x: -70deg, y: 0deg, z: -120deg)])
    })
  }),

  canvas({
    // import draw: *
    ortho(x: -110deg, y: 0deg, z: 20deg, {
      draw-cartesian(xl: 2, yl: 2, zl: 2, dash: "dashed")
      draw-cube(xl: 4, yl: 4, zl: 4)
      content((0, 0, -3.2), text(size: 8pt)[ortho(x: -110deg, y: 0deg, z: 20deg)])
    })
  }),
)

