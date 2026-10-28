// [UC-TeX] Portada, resumen y secciones finales sin numerar.
// `info` es el diccionario con todos los argumentos de report() (ver lib/template.typ).

#import "locales.typ": format-date, t, tn
#import "authors.typ": people-block, person-name

// Portada completa (página propia, una columna): logo, título entre reglas, asignatura,
// estudiantes/profesores/ayudantes, fechas.
#let cover-page(info) = {
  let lang = info.lang
  set par(leading: 0.65em, spacing: 0.65em, first-line-indent: 0pt)
  align(center)[
    #v(1.5cm)
    #if info.logo != none { image(info.logo, width: info.logo-scale * 100%) }

    #v(1cm)
    #line(length: 100%, stroke: 0.5mm)
    #v(0.2cm)

    #text(size: 1.67em, weight: "bold", info.title)

    #v(0.2cm)
    #line(length: 100%, stroke: 0.5mm)

    #v(1fr)

    #text(size: 1.2em, weight: "bold", t(lang, "subject")) \
    #info.subject.code - #info.subject.name

    #v(1cm)

    #people-block(info.authors, ..t(lang, "student"), orcid: info.orcid)

    #if info.professors.len() > 0 { v(0.5cm) }
    #people-block(info.professors, ..t(lang, "professor"), orcid: info.orcid)

    #if info.assistants.len() > 0 { v(0.5cm) }
    #people-block(info.assistants, ..t(lang, "assistant"), orcid: info.orcid)

    #v(1fr)

    #grid(
      columns: if info.lab-date != none { (1fr, 1fr) } else { (1fr,) },
      align: center,
      ..if info.lab-date != none {
        (
          [
            #text(size: 1.2em, weight: "bold", t(lang, "lab-date")) \
            #info.lab-date
          ],
        )
      } else { () },
      [
        #text(size: 1.2em, weight: "bold", t(lang, "report-date")) \
        #info.report-date
      ]
    )
  ]
}

// Portada corta: título, autores y línea de profesores/ayudantes al inicio de la página 1.
#let short-cover(info) = {
  align(center)[
    #text(size: 1.4em, weight: "bold", info.specific-title)

    #v(0.3cm)

    #info.authors.map(p => person-name(p, orcid: info.orcid)).join([, ])

    #v(0.3cm)

    #text(fill: gray, size: 0.9em)[
      #if info.professors.len() > 0 [
        #smallcaps(tn(info.lang, "professor", info.professors.len())): #info.professors.map(p => p.name).join(", ")
      ]
      #if info.professors.len() > 0 and info.assistants.len() > 0 [ \ ]
      #if info.assistants.len() > 0 [
        #smallcaps(tn(info.lang, "assistant", info.assistants.len())): #info.assistants.map(p => p.name).join(", ")
      ]
    ]
    #v(0.5cm)
  ]
}

#let uat(term, code) = {
  let href = "https://astrothesaurus.org/uat/" + str(code)
  [#link(href)[#term (#code)]]
}

// Resumen a ancho completo (ambas columnas) con palabras clave.
#let abstract-block(abstract, keywords, lang) = {
  if abstract == none { return }

  v(0.2cm)
  align(center, upper(t(lang, "abstract")))
  v(1mm)

  pad(x: 0.5in)[
    #set par(first-line-indent: (amount: 0.125in, all: true))
    #abstract

    #if keywords.len() > 0 [
      #v(0.4em)
      #par(first-line-indent: 0pt, hanging-indent: 1.5em)[_#t(lang, "keywords"):_ #keywords.join(" — ")]
    ]
  ]
  v(0.3cm)
}

#let acknowledgments(body) = context {
  let lang = text.lang
  heading(level: 1, numbering: none)[#t(lang, "acknowledgments")]
  body
}

#let contribution(body) = context {
  let lang = text.lang
  heading(level: 1, numbering: none)[#t(lang, "contribution")]
  body
}
