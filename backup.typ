#import "template.typ": *

#let inst_sdu = institute("School of Cyber Science and Technology, Shandong University")



#show: lncs.with(
  title: "Introduction to the provable security",
  //thanks: "Supported by organization x.",
  authors: (
    author("Chen Qian", 
      insts: (inst_sdu),
      //oicd: "0000-1111-2222-3333",
    ),
  ),
  //abstract: [],
  keywords: ("First keyword", "Second keyword", "Another keyword"),
  bibliography: bibliography(bytes(("/cryptobib/abbrev0.bib","/cryptobib/crypto.bib","refs.bib").map(read).join("\n")))
)


#include "chapters/intro.typ"
#include "chapters/UC.typ"

