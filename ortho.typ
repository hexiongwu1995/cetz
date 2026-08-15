#let set-projection(azimuth:30deg, elevation:30deg) = {
    import cetz.vector:*
    
    (ctx => {
        // save current translation
        let pr = cetz.draw.ortho
        let t1 = ctx.transform.at(0).at(3)
        let t2 = ctx.transform.at(1).at(3)
        let t3 = ctx.transform.at(2).at(3)

        // get scale
        let sx = len((ctx.transform.at(0).at(0), ctx.transform.at(1).at(0), ctx.transform.at(2).at(0)))
        let sy = len((ctx.transform.at(0).at(1), ctx.transform.at(1).at(1), ctx.transform.at(2).at(1)))
        let sz = len((ctx.transform.at(0).at(2), ctx.transform.at(1).at(2), ctx.transform.at(2).at(2)))

        // orthographic projection matrix
        let ortho-mat = (
            (sx, 0, -0.01, 0),
            (0, -sy, 0.01, 0),
            (0, 0, 0, 0),
            (0, 0, 0, 1),
        )

        let mat-1 = cetz.matrix.transform-rotate-x(-90deg)  // rotate x -90deg to have z pointing up
        let mat-2 = cetz.matrix.transform-rotate-z(-90deg - azimuth)  // rotate z -90deg to have x pointing to the viewer then rotate by azimuth

        let (l,m,n) = ( -calc.sin(azimuth), calc.cos(azimuth), 0) // new axis used for elevation 
        let (c, s) = (calc.cos(elevation), calc.sin(elevation))

        let mat-elevation = ( ( l*l*(1-c) + c, l*m*(1-c) -n*s, l*n*(1-c) + m*s, 0 ),
                              ( m*l*(1-c) + n*s, m*m*(1-c) + c, m*n*(1-c) - l*s, 0 ),
                              ( n*l*(1-c) - m*s, n*m*(1-c) + l*s, n*n*(1-c) + c, 0 ),
                              (0,0,0,1) )

        ctx.transform = cetz.matrix.mul-mat(ortho-mat, mat-1, mat-2, mat-elevation)

        // restore translation
        ctx.transform.at(0).at(3) = t1
        ctx.transform.at(1).at(3) = t2
        ctx.transform.at(2).at(3) = t3

        return (ctx: ctx)
    },)
}
