

#import "utility/utility.typ": *

#set page(paper: "a5")

#canvas({
  ortho(x: -70deg, y: 0deg, z: -120deg, {
    draw-cartesian(xl: 2, yl: 2, zl: 2, dash: "dashed")
    draw-cube(xl: 4, yl: 4, zl: 4)
    content((0, 0, -3.2), text(size: 8pt)[ortho(x: -70deg, y: 0deg, z: -120deg)])
  })
})


