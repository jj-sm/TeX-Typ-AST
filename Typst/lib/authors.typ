// [UC-TeX] Listas de personas en la portada.
// person = (name: str, orcid: str | none, email: str | none, affiliation: str | none)

#import "locales.typ": t, tn

// Nombre en versalitas; con orcid: true y p.orcid, nombre e ícono ORCID enlazados. Email/afiliación como nota al pie.
#let person-name(p, orcid: true) = {
  let name-part = if orcid and "orcid" in p and p.orcid != none {
    link("https://orcid.org/" + p.orcid)[#smallcaps(p.name)#h(0.5mm)#box(
        image("/resources/misc/orcid-ID.png", height: 0.7em),
        baseline: 10%,
      )]
  } else {
    smallcaps(p.name)
  }

  let fn-content = ()
  if "email" in p and p.email != none {
    fn-content.push(link("mailto:" + p.email, raw(p.email)))
  }
  if "affiliation" in p and p.affiliation != none {
    fn-content.push(p.affiliation)
  }

  if fn-content.len() > 0 {
    name-part += footnote(fn-content.join(", "))
  }

  name-part
}

// Encabezado singular/plural según la cantidad; no muestra nada si la lista está vacía.
#let people-block(people, singular, plural, orcid: true) = {
  if people.len() == 0 { return }
  align(center)[
    #text(size: 1.2em, weight: "bold", if people.len() == 1 { singular } else { plural }) \
    #people.map(p => person-name(p, orcid: orcid)).join(linebreak())
  ]
}
