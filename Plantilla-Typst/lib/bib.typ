// [UC-TeX] Bibliografía y citas: styles/aasjournal.csl (autor-año, ApJ) y styles/numeric.csl (IEEE).

#import "locales.typ": t

// Estilo para bibliography(); recibe "author-year" | "numeric".
#let bib-style(cite-style) = {
  if cite-style == "numeric" { "/styles/numeric.csl" } else { "/styles/aasjournal.csl" }
}

// Lista de referencias; columns: 1 la pone a ancho completo.
#let references(path, cite-style: "author-year", columns: 2, lang: "es") = {
  let bib = {
    show bibliography: it => {
      set text(size: 10.5pt)
      set par(justify: false, first-line-indent: 0pt, leading: 0.45em, spacing: 0.45em)
      show block: b => {
        if type(b.body) == content and repr(b.body.func()) == "pdf-marker-tag" {
          pad(left: 1em, top: 0.1em, bottom: 0.1em, par(first-line-indent: (amount: -1em, all: true), b.body))
        } else {
          b
        }
      }
      it
    }
    bibliography(path, title: t(lang, "references"), style: bib-style(cite-style))
  }
  if columns == 1 {
    // A ancho completo en una página nueva (Typst no equilibra columnas a mitad de página);
    // así la lista puede continuar en varias páginas.
    page(columns: 1, bib)
  } else {
    bib
  }
}

// Configuración que report() deja para references-here().
#let _refs-config = state("uc-refs-config", none)

// Pone la bibliografía en este punto (p. ej. antes de `#show: appendix`, como en Main.tex).
// Si no se llama, report() la pone al final del documento.
#let references-here() = {
  [#metadata("uc-refs-here") <uc-refs-here>]
  context {
    let c = _refs-config.get()
    if c != none and c.path != none {
      references(c.path, cite-style: c.cite-style, columns: c.columns, lang: c.lang)
    }
  }
}

// \citet -> "Autor (2020)";  \citep -> "(Autor 2020)".
#let citet(key) = {
  let l = if type(key) == str { label(key) } else { key }
  cite(l, form: "prose")
}

#let citep(key) = {
  let l = if type(key) == str { label(key) } else { key }
  cite(l, form: "normal")
}
