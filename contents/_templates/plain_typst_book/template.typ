#import "@preview/marge:0.1.0"
#import "style.typ": template
#import "aside_style.typ": aside
#show: template.with(

// title
  title: "[-doc.title-]",

// subtitle
[# if doc.subtitle #]
  subtitle: "[-doc.subtitle-]",
[# endif #]

// authors
[# if doc.authors #]
  authors: "[# for author in doc.authors #][- author.name -][# if not loop.last #], [# endif #][# endfor #]",
[# endif #]


// logo for top page
[# if options.logo #]
  logo: "[-options.logo-]",
[# endif #]

// specify the with of the logo
[# if options.logo_width #]
  logo_width: [-options.logo_width-]%,
[# endif #]


// cover picture
[# if options.cover #]
  cover: "[-options.cover-]",
[# endif #]

[# if options.cover_width #]
  cover_width: [-options.cover_width-]cm,
[# endif #]

[# if options.coverposition #]
  coverposition: [-options.coverposition-]cm,
[# endif #]



//specify depth of table of contents

[# if options.show_ToC is defined#]
  show_ToC: [-options.show_ToC-],
[# endif #]

[# if options.ToC_depth #]
  ToC_depth: [-options.ToC_depth-],
[# endif #]



//Page settings
[# if options.papersize #]
  paper-size: "[-options.papersize-]",
[# endif #]

[# if options.show_pagenumber is defined #]
  show_pagenumber: [-options.show_pagenumber-],
[# endif #]

[# if options.margin_top #]
  margin_top: [-options.margin_top-]cm,
[# endif #]

[# if options.margin_bottom #]
  margin_bottom: [-options.margin_bottom-]cm,
[# endif #]

[# if options.margin_left #]
  margin_left: [-options.margin_left-]%,
[# endif #]

[# if options.margin_right #]
  margin_right: [-options.margin_right-]%,
[# endif #]

[# if options.colortheme #]
  theme: [-options.colortheme-],
[# endif #]

[# if options.colorheadings #]
  colorheadings: [-options.colorheadings-],
[# endif #]

[# if options.fontstyle #]
  font: "[-options.fontstyle-]",
[# endif #]

[# if options.fontsize #]
  fontsize: [-options.fontsize-]pt,
[# endif #]

[# if options.linespacing #]
  linespacing: [-options.linespacing-]em,
[# endif #]

[# if options.justification is defined #]
  justification: [-options.justification-],
[# endif #]

[# if options.preface is defined #]
  preface: "[-options.preface-]",
[# endif #]

)



[-IMPORTS-]

[-CONTENT-]

[# if doc.bibtex #]
#{
  show bibliography: set text(8pt)
  bibliography("[-doc.bibtex-]", title: text(10pt, "References"), style: "apa")
}
[# endif #]
