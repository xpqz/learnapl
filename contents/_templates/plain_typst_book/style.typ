  
#let leftCaption(it) = {
  set text(size: 8pt)
  set align(left)
  set par(justify: true)

  // Within the context of the element, you may use the counter
  context(it, {
    text(weight: "bold")[#it.supplement #it.counter.display(it.numbering).]
  })

  h(4pt)
  set text(fill: black.lighten(20%), style: "italic")
  it.body
}


#let template(
  // FRONTPAGE.
  title: "Book Title",
  subtitle: none,
  authors: "Your name",
  cover: none,            // <— path to cover "images/cover.png"
  cover_width: 12cm,    
  coverposition: 1cm,
  justification: false,

  // TOC
  ToC_depth: 2,
  show_ToC: true,

  // PREFACE
  preface: none,

  // SPECIFICATION of output
  paper-size: "a4",       // https://typst.app/docs/reference/layout/page/#parameters-paper
  margin: (),                          
  linespacing: .5em,
  show_pagenumber: true,
  margin_top: 2cm,
  margin_bottom: 2cm,
  margin_left: 20%,
  margin_right: 10%,
  logo: none,
  logo_width: 10%,
  
  font: "Libertinus Serif", 
  fontsize: 11pt,

  theme: red.darken(30%),
  colorheadings: black,
  
  // The book's content.
  body
) = {

  set page(
    numbering: none,
    paper-size,
    ) //numbering off until first chapter
  
  set heading(numbering: (..args) => {
    let nums = args.pos()
    let level = nums.len()
    if level == 1 {[#numbering("1.", ..nums)]} else {[#numbering("1.1.1", ..nums)]}
    },   
    
)

  // Set figure numbering to x.y where x is chapter number and y is figure number within chapter

  set figure(numbering: (..args) => {
    // get current chapter number (first level of heading)
    let chapter = counter(heading).display((..nums) => nums.pos().at(0)) // nums is array of all levels, at(0) is first level, display formats it.  
    let fig = counter(figure).display("1")    // counter counts, display formats it
    [#chapter.#fig]
  })
  

  // Configure equation numbering and spacing.
  set math.equation(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [(#chapter.#numbering("1)", ..args.pos())]
  })
  show math.equation: set block(spacing: 1em)


  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // link behaviour
  show link: set text( fill: blue.darken(30%))

// COVERPAGE
  // Title, subtitle, 
  align(center, text(17pt, weight: "bold", fill: theme, title))
  if subtitle != none {
    parbreak()
    box(text(14pt, fill: gray.darken(30%), subtitle))
  }

    if cover != none {
      v(coverposition)
      align(center, image((cover), width: cover_width))
    }

  //author
  v(1em)

  // authors in gray
  if authors != none {
  place(bottom + right, 
    text(12pt, fill: gray.darken(50%), authors)
  )

  }


// PREFACE, 
  if preface != none {
    pagebreak()
    place(top + left, 
      text(14pt, fill: theme, "Preface")
    )
    v(1em)
    set par(justify: true)
    align(center, box(width: 70%, text(11pt, overhang: true, font:  "New Computer Modern", fill: gray.darken(30%), preface)))
  }


//OUTLINE OF THE BOOK
  pagebreak()
  if show_ToC == true {
      
    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      
      strong(it)
    }
    // setting outline in themecolor
    outline(
    title: strong(text(fill: theme, "Contents")),
    depth: ToC_depth,
    indent: auto,
  )

  }

//RESETING NUMBERING
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    // Reset all counters with a new chapter
    counter(figure).update(0)                // all figures (irrespective of kind)
    counter(figure.where(kind: table)).update(0) // specific for tables
    counter(math.equation).update(0)
    
    it
  }

  //Heading colors
  show heading: set text(colorheadings)
  

// PAGE LAYOUT OF CONTENT
  set page(
    numbering: if show_pagenumber == true {"1"} else {none},         //turn on numbering
    margin: (
      top: margin_top,
      bottom: margin_bottom,
      left: margin_left,
      right: margin_right 
      ),    //set left margin
    header: if logo != none { align(center)[#image(logo, width: logo_width)] } else { none },//include logo
    footer: if show_pagenumber == true {
      [
        #set text(size: 9pt, fill: gray.darken(30%))
        #text(title)
        #h(1fr)
        #context counter(page).display("1")
      ]
    } else { none },
  )   

  set text(
    font: font,
    size: fontsize
    )
  set par(
    leading: linespacing,
    justify: justification
    )

  counter(page).update(1)   //set number to 1

  // learnapl: render all code and output in APL387
  show raw: set text(font: "APL387")

  // learnapl: frame code cells and their output as panels, like the site.
  // Input cells (```apl) get a blue left rule; cell output (```output, tagged
  // by tools/patch-typst.py) a green one; prose fenced blocks stay plain.
  // Colours match the site: border gray-200, blue-400, emerald-400.
  let panel(accent, body) = block(
    width: 100%,
    stroke: (
      left: 3pt + accent,
      top: 0.6pt + rgb("#e5e7eb"),
      right: 0.6pt + rgb("#e5e7eb"),
      bottom: 0.6pt + rgb("#e5e7eb"),
    ),
    inset: (x: 8pt, y: 5pt),
    radius: 2pt,
    above: 8pt,
    below: 8pt,
    breakable: false,
  )[#body]
  show raw.where(block: true, lang: "apl"): it => panel(rgb("#60a5fa"), it)
  // learnapl: output cells get a tighter line pitch so box-drawing tables
  // render as continuous lines (APL387's line box is taller than its glyphs,
  // which leaves visible gaps between the rows of box-drawn tables).
  show raw.where(block: true, lang: "output"): it => panel(rgb("#34d399"), [#set par(leading: 0.25em); #it])

  // learnapl: style block quotes like the site: italic text with a gray
  // left rule.
  show quote.where(block: true): it => block(
    width: 100%,
    stroke: (left: 3pt + rgb("#d1d5db")),
    inset: (left: 10pt, top: 2pt, bottom: 2pt),
    above: 12pt,
    below: 12pt,
  )[#set text(style: "italic"); #it.body]

  // Display the book's contents.
  [#body]
}
