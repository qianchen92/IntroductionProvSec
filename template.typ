#import "template/theorem_proof_cnf.typ": *

// all theorem related elements
#let (
  theorem,
  __thm-rules,
  definition,
  __def-rules,
  proposition,
  __prop-rules,
  lemma,
  __lem-rules,
  proof,
  __proof-rules,
  corollary,
  __corol-rules,
) = __llncs_thm_cnf()


// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let lncs(
  title: [Contribution Title],
  thanks: none,
  abstract: [],
  authors: (),
  keywords: (),
  // The result of a call to the `bibliography` function or `none`.
  bibliography: none,
  body,
) = {
  //// CONSTANTS
  let PAR_INDENT = 15pt
  let TOP_PAGE_MARING = 50mm
  let TITLE_SIZE = 14pt

  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "New Computer Modern", lang: "en", size: 10pt)


  //// EVALUATIONS
  let author_running = {
    let an = authors.map(it => {
      let ns = it.name.split(" ")
      [#ns.at(0).at(0). #ns.last()]
    })
    if an.len() < 2 {
      an.join(", ")
    } else {
      [#an.first() et al.]
    }
  }

  //// PAR CONFIG
  set par(leading: 0.50em, spacing: 0.4em)

  //// PAGE CONFIG
  set page(paper: "us-letter")
  set page(margin: (left: 44mm, right: 44mm, top: TOP_PAGE_MARING, bottom: 45mm))
  // set page header
  set page(
    header: context {
      let pagenumer = counter(page).get().first()
      if pagenumer == 1 { return [] }

      if (calc.rem(pagenumer, 2) == 1) {
        align(right)[
          #title
          #h(1cm)
          #counter(page).display()
        ]
      } else {
        align(left)[
          #counter(page).display()
          #h(1cm)
          #author_running
        ]
      }
    },
  )

  //// HEADING CONFIGS
  set heading(numbering: "1.1")
  show heading: it => if it.numbering == none { it } else { block(counter(heading).display(it.numbering) + h(1em) + it.body) }
  // padding
  show heading.where(level: 1): pad.with(bottom: 0.64em, top: 0.64em)
  show heading.where(level: 2): pad.with(bottom: 0.9em)
  show heading: it => {
    if it.level == 1 {
      set text(12pt, weight: "bold")
      it
    } else if it.level == 2 {
      set text(10pt, weight: "bold")
      it
    } else if it.level == 3 {
      set text(10pt, weight: "bold")
      [#v(2em)#h(-PAR_INDENT) #it.body]
    } else if it.level == 4 {
      set text(10pt, weight: "regular", style: "italic")
      [#v(1.5em)#h(-PAR_INDENT)#it.body]
    }
  }


  //// SUPER CONFIGS
  set super(size: 8pt)

  //// FOOTNOTE CONFIGS
  show footnote.entry: set text(9pt)
  set footnote.entry(separator: line(length: 54pt, stroke: 0.5pt))

  /////  FIGURE CONFIG
  set figure.caption(separator: [. ]) // separator to .
  show figure.caption: it => [*#it.supplement #context it.counter.display()#it.separator*#it.body] // bold figure kind
  show figure.where(kind: table): set figure.caption(position: top) // caption for table above figure
  set figure(gap: 12pt)
  show figure: pad.with(top: 20pt, bottom: 20pt)
  show figure: set text(9pt)
  // let Figure display as Fig
  let fig_replace(it) = {
    show "Figure": "Fig."
    it
  }
  show figure.where(kind: image): fig_replace
  show ref: fig_replace


  //// ---- Start of content -----

  v(-9mm)

  // Title row.
  align(center)[
    #block()[
      #text(weight: "bold", TITLE_SIZE, title)
      #if type(thanks) == str and thanks.trim() != "" {
        set super(size: 10pt)
        footnote(numbering: it => [⋆#h(2pt)], thanks)
      }
    ]
  ]

  v(6mm)

  // encapsulated styling
  {
    set align(center)


    let insts = authors.map(it => it.insts).flatten().dedup()

    // Author information.

    authors
      .enumerate()
      .map(it => {
        let a = it.at(1)
        // find references
        let refs = a.insts.map(ai => str(insts.position(i => i == ai) + 1)).join(",")

        let oicd = if a.oicd != none { [[#a.oicd]] } else { "" }

        // add "and" infront of last author
        let und = if it.at(0) > 0 and it.at(0) == authors.len() - 1 { "and" } else { "" }

        [#und #a.name#super([#refs#oicd])]
      })
      .join(", ")


    v(3mm)

    // Institute information.
    insts
      .enumerate()
      .map(it => {
        set text(9pt)

        let inst = it.at(1)
        [#super([#{ it.at(0) + 1 }]) ]
        [#inst.name]
        if "addr" in inst [, #inst.addr]
        if "email" in inst [#text(font: "PT Mono", size: 8pt, inst.email)]
        if "url" in inst [#inst.url]
      })
      .map(par)
      .join()


    v(11.5mm)


    // abstract and keywords.
    block(width: 10cm)[
      #set align(left)
      #set par(justify: true)
      *Abstract.* #abstract
      #v(3.5mm)
      #if keywords.len() > 0 {
        let display = if type(keywords) == str { keywords } else { keywords.join([ $dot$ ]) }
        text[*Keywords:* #display]
      }
    ]
  }

  v(1mm)

  // Main body.

  //// PAR CONFIG MAIN
  set par(justify: true, first-line-indent: PAR_INDENT)

  // show theorem rules
  show: __thm-rules
  show: __def-rules
  show: __prop-rules
  show: __lem-rules
  show: __proof-rules
  show: __corol-rules

  // show actual body
  body

  v(8pt)

  // Style bibliography.
  show std.bibliography: set text(9pt)
  set std.bibliography(title: text(12pt)[References], style: "springer-lecture-notes-in-computer-science")

  // Display bibliography.
  bibliography
}

/// Author creation function
#let author(name, oicd: none, insts: ()) = {
  // make sure it is always an one dimensional array
  if type(insts) != array {
    insts = (insts,)
  }

  (
    name: name,
    oicd: oicd,
    insts: insts,
  )
}


/// Institute creation function
#let institute(name, addr: "", email: none, url: none) = {
  (
    name: name,
    addr: addr,
    email: if email != none { link("mailto: " + email) } else { none },
    url: if url != none { link(url) } else { none },
  )
}
