// Custom typst element (https://typst.app/docs/reference/)

#let aside(title, body) = { 

    // Title block
    block(
        // Outer block styled like a note block
        fill: rgb(244, 147, 147), // background - VS code automatically changes this to rgba sometimes which does not work.
        stroke: (left: 1pt + red),  // red line on the left 
        width: 100%,

        // add padding top and bottom
        inset: (x: 0.8em, y: 0.4em),
        above: 0.5em,               //distance top to next element above
        below: 0em,                 //distance bottom to next element below                

        strong(title)
    )
    block(
        // Inner block for the body of the aside
        fill: rgb(240, 240, 240),        // white background
        stroke: (left: 1pt + red),
        width: 100%,

        // add padding top and bottom
        inset: (x: 0.8em, y: 0.6em),
        above: 0em,
        below: 0.5em,

        body
    )
}


