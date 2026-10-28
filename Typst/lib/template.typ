// [UC-TeX] Plantilla UC (AST/FIZ) para Typst — función principal `report`.
//
// ===================================== API PÚBLICA (estable) =====================================
// Los nombres y argumentos de estas funciones se mantienen estables entre versiones.
// main.typ importa todo con:  #import "lib/template.typ": *
//
// report(                               // #show: report.with(..info, abstract: [...], keywords: (...))
//   lang: "es",                         // "es" | "en"
//   style: "preprint2",                 // "default" | "twocolumn" | "preprint" | "preprint2" | "manuscript" | "modern"
//   cover: "full",                      // "full" (portada propia) | "short" (título al inicio de la pág. 1)
//   logo: none, logo-scale: 0.6,        // ruta absoluta desde la raíz, p. ej. "/resources/logos/AST-h-black.png"
//   title: none, specific-title: none,  // título largo (portada) y específico (portada corta)
//   subject: (code: none, name: none),
//   authors: (), professors: (), assistants: (),
//       // persona = (name: str, orcid: str | none, email: str | none, affiliation: str | none)
//   lab-date: none,                     // contenido; none la oculta y centra la fecha del informe
//   report-date: auto,                  // auto = hoy, según el idioma; o contenido
//   orcid: true,                        // muestra el ícono ORCID enlazado
//   short-title: none, short-authors: none,  // encabezados de página
//   abstract: none, keywords: (),
//   cite-style: "author-year",          // "author-year" | "numeric"
//   bibliography: none,                 // ruta absoluta, p. ej. "/Bibliography.bib"
//   refs-columns: 2,                    // 1 | 2 columnas para las referencias
//   body,
// )
//
// lib/locales.typ
//   t(lang, key)  ·  tn(lang, key, n)  ·  format-date(lang, datetime)
// lib/cover.typ            `info` = diccionario con todos los argumentos de report()
//   cover-page(info)  ·  short-cover(info)  ·  abstract-block(abstract, keywords, lang)
//   acknowledgments(body)  ·  contribution(body)
// lib/authors.typ
//   person-name(p, orcid: true)  ·  people-block(people, singular, plural, orcid: true)
// lib/bib.typ
//   bib-style(cite-style)  ·  references(path, cite-style: .., columns: 2, lang: ..)
//   citet(key)  ·  citep(key)
//   references-here()                    // bibliografía en ese punto; sin llamarla va al final
// lib/helpers.typ
//   todo-error(body)  todo-warn(body)  todo-remark(body)  todo-hint(body)  todo-done(body)
//   todo-short(body)  todo-list()
//   facilities(..items)  software(..items)  softwarecode(..items)  softwareai(..items)  dataset(..items)
//   appendix(body)                       // #show: appendix
//   deluxetable(caption: none, columns: (), header: (), rows: (), comments: none, wide: false)
//   headgroup(body)
//   ra(h, m, s)  dec(d, m, s)  object(name, id: none)  cfeh  diff  cint  vdag
//   missing-figure(width: 100%, height: 4cm, body)  subfig(img, width: 100%, caption: none)
//   gridline(..figs)
// resources/cetz/celestial-sphere.typ
//   celestial-sphere(..)                 // se importa aparte desde el archivo de la sección
// =====================================================================================================

#import "locales.typ": format-date, t, tn
#import "authors.typ": *
#import "cover.typ": *
#import "bib.typ": *
#import "helpers.typ": *

#let link-color = rgb("#3d3d9e")

#let report(
  lang: "es",
  style: "preprint2",
  cover: "full",
  logo: none,
  logo-scale: 0.6,
  title: none,
  specific-title: none,
  subject: (code: none, name: none),
  authors: (),
  professors: (),
  assistants: (),
  lab-date: none,
  report-date: auto,
  orcid: true,
  short-title: none,
  short-authors: none,
  abstract: none,
  keywords: (),
  cite-style: "author-year",
  bibliography: none,
  refs-columns: 2,
  body,
) = {
  assert(lang in ("es", "en"), message: "lang debe ser \"es\" o \"en\"")
  assert(cover in ("full", "short"), message: "cover debe ser \"full\" o \"short\"")
  assert(cite-style in ("author-year", "numeric"), message: "cite-style debe ser \"author-year\" o \"numeric\"")
  assert(style in ("default", "twocolumn", "preprint", "preprint2", "manuscript", "modern"), message: "style no válido")

  let info = (
    lang: lang,
    style: style,
    cover: cover,
    logo: logo,
    logo-scale: logo-scale,
    title: title,
    specific-title: specific-title,
    subject: subject,
    authors: authors,
    professors: professors,
    assistants: assistants,
    lab-date: lab-date,
    report-date: if report-date == auto { format-date(lang, datetime.today()) } else { report-date },
    orcid: orcid,
    short-title: short-title,
    short-authors: short-authors,
    abstract: abstract,
    keywords: keywords,
    cite-style: cite-style,
    bibliography: bibliography,
    refs-columns: refs-columns,
  )

  set document(title: title, author: authors.map(a => a.name))
  _refs-config.update((path: bibliography, cite-style: cite-style, columns: refs-columns, lang: lang))


  // --- Estilos de página y texto ---
  let is_two_col = style in ("twocolumn", "preprint2")
  let base_size = if style in ("preprint", "preprint2", "manuscript", "modern") { 12pt } else { 10pt }
  let doc_font = if style == "modern" { ("PT Sans", "Arial", "Helvetica", "sans-serif") } else { "New Computer Modern" }
  let (is_double_spaced, doc_leading, doc_spacing) = if style == "manuscript" { (true, 1.2em, 1.2em) } else { (false, 0.55em, 0.55em) }

  set page(
    paper: "us-letter",
    margin: (x: 0.7in, top: 0.9in, bottom: 0.85in),
    columns: if is_two_col { 2 } else { 1 },
    header-ascent: 35%,
    header: context {
      let p = counter(page).get().first()
      if p == 1 { return }
      let head = if calc.even(p) { short-authors } else { short-title }
      block(width: 100%, stroke: (bottom: 0.4pt), inset: (bottom: 4pt), grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        if calc.even(p) [#p], smallcaps(head), if calc.odd(p) [#p],
      ))
    },
  )
  set columns(gutter: 0.3125in)
  set text(font: doc_font, size: base_size, lang: lang)
  set smartquote(quotes: ("“", "”"))
  set par(justify: true, leading: doc_leading, spacing: doc_spacing, first-line-indent: (amount: 0.125in, all: true))

  // --- Notas al pie: sin línea divisoria (como \let\footnoterule\relax en TeXAST.cls) ---
  set footnote.entry(separator: none, indent: 0pt)
  show footnote.entry: it => {
    let loc = it.note.location()
    let num = numbering(it.note.numbering, ..counter(footnote).at(loc))
    set par(first-line-indent: 0pt)
    block(above: 0.4em, below: 0.2em, text(size: 10pt)[#super[#num] #it.note.body])
  }

  // --- Títulos: centrados; nivel 1 en mayúsculas, niveles 2+ en cursiva ---
  set heading(numbering: "1.1.")
  show heading: it => {
    let sz = if it.level >= 3 { base_size - 1pt } else { base_size }
    let num-sz = if it.level == 1 or it.level >= 3 { base_size - 1pt } else { base_size }
    let num = if it.numbering != none {
      text(size: num-sz, style: "normal", counter(heading).display(it.numbering)) + h(0.4em)
    }
    let title = if it.level == 1 { upper(it.body) } else { emph(it.body) }
    set text(size: sz, weight: "regular")
    set par(first-line-indent: 0pt)
    block(width: 100%, above: 1.05em, below: 0.6em, align(center, num + title))
  }

  // --- Ecuaciones, figuras, tablas y bloques de código ---
  set math.equation(numbering: "(1)")
  // @ec:... muestra solo el número (como \ref), sin "Ecuación".
  show ref: it => {
    let el = it.element
    if el == none or el.func() != math.equation { return it }
    let loc = el.location()
    let eq = counter(math.equation).at(loc).first()
    // En el apéndice (numeración por función): letra de la sección + número, p. ej. A1.
    let n = if type(el.numbering) == function {
      numbering("A", counter(heading).at(loc).first()) + str(eq)
    } else { str(eq) }
    link(loc, n)
  }
  show math.equation.where(block: true): set block(above: 0.65em, below: 0.65em)
  show figure: set block(above: 0.85em, below: 0.85em)
  show figure.where(kind: image): set figure(supplement: t(lang, "figure"), placement: auto)
  show figure.where(kind: table): set figure(supplement: t(lang, "table"))
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: t(lang, "code"))
  show raw.where(block: true): it => block(
    width: 100%,
    inset: (x: 6pt, y: 5pt),
    stroke: 0.5pt + luma(160),
    fill: rgb(96%, 96%, 93%),
    {
      show raw.line: line => {
        box(width: 12pt, align(right, text(fill: luma(150), size: 0.8em, str(line.number))))
        h(6pt)
        line.body
      }
      align(left, text(size: 9.5pt, it))
    }
  )
  show figure.caption: it => context {
    if it.numbering == none or it.supplement == none { return align(center, text(size: base_size - 1pt, it.body)) }
    let cap = text(size: base_size - 1pt)[*#it.supplement #it.counter.display(it.numbering).* #it.body]
    layout(size => {
      if measure(cap).width <= size.width {
        align(center, cap)
      } else {
        align(left, par(justify: true, first-line-indent: 0pt, leading: 0.48em, cap))
      }
    })
  }

  // --- Enlaces, citas y referencias cruzadas en azul ---
  show link: set text(fill: link-color)
  show cite: set text(fill: link-color)
  show ref: set text(fill: link-color)

  // --- Portada + resumen ---
  if cover == "full" {
    page(columns: 1, header: none, cover-page(info))
    place(top, scope: "parent", float: true, abstract-block(abstract, keywords, lang))
  } else {
    place(top, scope: "parent", float: true, {
      short-cover(info)
      abstract-block(abstract, keywords, lang)
    })
  }

  body

  // Al final solo si el documento no llamó references-here().
  if bibliography != none {
    context if query(<uc-refs-here>).len() == 0 {
      references(bibliography, cite-style: cite-style, columns: refs-columns, lang: lang)
    }
  }
}
