#import "utility/utility.typ": draw-cartesian, draw-cube


#import "@preview/cetz:0.5.2": canvas, draw




#grid(
  columns: (1fr, 1fr),
  rows: auto,
  gutter: 5mm,

  canvas({
    import draw: *
    draw-cartesian()
    content((0, -1, 0), [hello])
  }),

  canvas({
    import draw: *
    ortho(x: -70deg, y: 0deg, z: -120deg,{
      draw-cartesian()
      draw-cube()
      content((0, -2, 0), [default ortho transform])
    })
  }),
)

