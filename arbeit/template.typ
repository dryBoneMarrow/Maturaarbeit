#import "@preview/codly:1.3.0": *

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  abstract: [],
  authors: (),
  category: "",
  institution: "",
  date: none,
  logo: none,
  body,
) = {
  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.1": *
  show: codly-init.with()
  codly(zebra-fill: none)
  // Set the document's basic properties.
  set page(numbering: none, paper: "a4", margin: 100pt)
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "New Computer Modern", lang: "de", region: "ch")
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")
  show table: set align(center)
  set table(
    align: left,
  )
  show table.cell.where(y: 0): strong

  show raw.where(block: true): set text(size: .78em)
  // show raw.where(block: true): block.with(
  //   fill: luma(240),
  //   inset: 5pt,
  //   radius: 4pt,
  //   spacing: 1em,
  // )
  // show raw.where(block: true): set align(right)

  set text(size: 11.5pt)
  // set par(leading: 0.65em)
  // Macros
  show selector(<nonumber>): set heading(numbering: none)

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        #author.name \
        Betreut durch #author.tutor \ \
      ]),
    ),
  )
  category
  linebreak()
  institution

  v(2.4fr)
  pagebreak()


  // Abstract page.
  // Beginning here line numbering
  set page(numbering: "1", number-align: center)
  counter(page).update(1)
  v(1fr)
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
    #abstract
  ]
  v(1.618fr)
  pagebreak()

  // Table of contents.
  outline(depth: 3)
  pagebreak()

  // Main body.
  set par(justify: true)
  // show bibliography: none
  body
}
#let red = rgb("#f77e7e");
#let lookatme(input) = { text(fill: red, weight: "bold", size: 15pt)[#input] }

