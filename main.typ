// #import "@preview/lyceum:0.1.0": FRONT-MATTER
#import "commands/commands.typ": *
#import "@preview/lyceum:0.1.0": FRONT-MATTER, BODY-MATTER, APPENDIX, BACK-MATTER
#show: thmrules.with(qed-symbol: $square$)
#show link: underline

#let TEXT-SIZE = 11pt

//----------------------------------------------------------------------------//
//                                FRONT-MATTER                                //
//----------------------------------------------------------------------------//

#show: FRONT-MATTER.with(
  // Document metadata
  title: (
    title: "Provable Security",
    subtitle: "Course Notes",
  ),
  authors: (
    (
      given-name: "Qian",
      name: "Chen",
      affiliation: "School of Cyber Science and Technology, Shandong University",
      email: "chen.qian@sdu.edu.cn",
    )
  ),
  editors: ("Chen Qian",),
  publisher: "Home Made",
  location: "Qingdao, Shandong, China",
  affiliated: (
    illustrator: ("Chen Qian",),
    organizer: "Shandong University",
  ),
  keywords: ("Cryptography", "Provable Security", "Simulation"),
  date: auto, // auto => datetime.today()
  // Document general format
  page-size: (width: 210mm, height: 297mm),
  page-margin: (inside: 30mm, rest: 25mm),
  page-binding: left,
  page-fill: color.hsl(45deg, 15%, 85%), // ivory
  text-font: ("EB Garamond", "Libertinus Serif"),
  text-size: TEXT-SIZE,
  lang-name: "en",
)

// The lyceum auto-generates the title page


// Show rule for the outline
#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}


= Contents

#outline(
  title: none,
  target: heading.where(level: 1),
  indent: auto,
)


//----------------------------------------------------------------------------//
//                                BODY-MATTER                                 //
//----------------------------------------------------------------------------//

#show: BODY-MATTER.with(TEXT-SIZE, "Chapter", ship-part-page: false)

#include "chapters/intro.typ"
#include "chapters/UC.typ"



//----------------------------------------------------------------------------//
//                                  APPENDIX                                  //
//----------------------------------------------------------------------------//

#show: APPENDIX.with(TEXT-SIZE, "Appendix", ship-part-page: true)

= References
#bibliography(
  bytes(("/cryptobib/abbrev0.bib", "/cryptobib/crypto.bib", "refs.bib").map(read).join("\n")),
  style: "iso-690-author-date",
)


//----------------------------------------------------------------------------//
//                                BACK-MATTER                                 //
//----------------------------------------------------------------------------//

#show: BACK-MATTER.with(TEXT-SIZE, ship-part-page: false)

= Citing This Book

The following is the _auto-generated_, self bibliography database entry for the *`hayagriva`*
manager:

#block(width: 100%)[
  #let self-bib = context query(<self-bib-entry>).first().value
  #set par(leading: 0.5em)
  #text(font: "Inconsolata", size: 9pt, weight: "bold")[
    #self-bib
  ]
]


