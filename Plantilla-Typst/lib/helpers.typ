// [UC-TeX] Ayudas para el cuerpo del informe.

#import "locales.typ": t

// --- Notas de pendientes (colores de Input.tex) ---
#let _todo(fill, body) = block(fill: fill, stroke: 0.5pt + black, radius: 3pt, inset: 5pt, width: 100%, {
  set par(first-line-indent: 0pt)
  text(size: 0.85em)[
    #context {
      let sup = t(text.lang, "todos")
      show figure.where(kind: "todo"): it => {}
      let swatch = box(width: 0.6em, height: 0.6em, fill: fill, stroke: 0.5pt + black, baseline: 10%)
      figure(kind: "todo", supplement: sup, numbering: none, caption: [#swatch#h(0.4em)#body], none)
    }
    #body
  ]
})
// Colores de xcolor: red!70, orange, yellow!80!black, green!20, blue!50.
#let _red = rgb(255, 0, 0)
#let _yellow = rgb(255, 255, 0)
#let _green = rgb(0, 255, 0)
#let _blue = rgb(0, 0, 255)
#let todo-error(body) = _todo(_red.lighten(30%), body)
#let todo-warn(body) = _todo(rgb(255, 128, 0), body)
#let todo-remark(body) = _todo(_yellow.darken(20%), body)
#let todo-hint(body) = _todo(_green.lighten(80%), body)
#let todo-done(body) = _todo(_blue.lighten(50%), body)
#let todo-short(body) = box(fill: _yellow.darken(20%), inset: 2pt, text(size: 0.8em, body))
#let todo-list() = context outline(title: t(text.lang, "todos"), target: figure.where(kind: "todo"))

// --- Bloques finales (\facilities, \software, ...) ---
#let _labelled(label, items) = context block(above: 0.65em, below: 0.65em)[
  #text(size: 14pt, style: "italic")[#t(text.lang, label):] #items.pos().join(", ")
]
#let facilities(..items) = _labelled("facilities", items)
#let software(..items) = _labelled("software", items)
#let softwarecode(..items) = _labelled("softwarecode", items)
#let softwareai(..items) = _labelled("softwareai", items)
#let dataset(..items) = _labelled("dataset", items)

// --- Apéndice: `#show: appendix` letra las secciones (A, B...) y las ecuaciones (A1) ---
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1.")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }
  set math.equation(numbering: n => {
    context {
      let h = counter(heading).get().first()
      "(" + numbering("A", h) + str(n) + ")"
    }
  })
  context block(sticky: true, width: 100%, above: 1.2em, below: 0.6em, align(center, upper(t(text.lang, "appendix"))))
  body
}

// --- Tablas estilo deluxetable ---
// columns: alineación por columna, como en LaTeX: ("l", "c", "r") o (left, center, right).
#let headgroup(body) = (is-headgroup: true, body: body)
#let deluxetable(caption: none, columns: (), header: (), rows: (), comments: none, wide: false) = {
  let processed-rows = ()
  for row in rows {
    if type(row) == dictionary and "is-headgroup" in row {
      processed-rows.push(table.cell(colspan: columns.len(), align: center, row.body))
      processed-rows.push(table.hline(stroke: 0.5pt))
    } else if type(row) == array {
      processed-rows += row
    } else {
      processed-rows.push(row)
    }
  }

  let aligns = columns.map(c => if type(c) == alignment { c } else {
    (l: left, c: center, r: right).at(c, default: center)
  })
  let raw-table = table(
    columns: columns.len(),
    align: aligns,
    inset: (x: 5pt, y: 3pt),
    stroke: none,
    table.hline(stroke: 0.6pt),
    ..header,
    table.hline(stroke: 0.5pt),
    ..processed-rows,
    table.hline(stroke: 0.6pt)
  )
  let styled-table = text(size: 11pt, box(stroke: (top: 0.6pt), inset: (top: 1.5pt), raw-table))

  let content = if comments == none {
    styled-table
  } else {
    layout(size => context {
      let tw = calc.min(measure(styled-table).width, size.width)
      let note-prefix = smallcaps(t(text.lang, "note")) + [—]
      block(width: if tw > 0pt { tw } else { 100% })[
        #align(center, styled-table)
        #v(2pt)
        #set text(size: 11pt)
        #set par(justify: true, first-line-indent: 0pt, hanging-indent: 6pt, leading: 0.45em)
        #align(left)[#note-prefix#comments]
      ]
    })
  }

  if wide {
    figure(kind: table, caption: caption, placement: top, scope: "parent", content)
  } else {
    figure(kind: table, caption: caption, content)
  }
}

// --- Macros astronómicas y matemáticas ---
#import "@preview/unify:0.8.1": num, qty, unit

#let _pad-num(n, digits: 2) = {
  if type(n) == content and n.has("text") {
    let s = n.text
    while s.len() < digits { s = "0" + s }
    s
  } else if type(n) in (int, float, str) {
    let s = str(n)
    while s.len() < digits { s = "0" + s }
    s
  } else {
    n
  }
}

#let ra(h, m, s) = {
  let hp = _pad-num(h, digits: 2)
  let mp = _pad-num(m, digits: 2)
  let sp = _pad-num(s, digits: 2)
  $#hp^"h"\, #mp^"m"\, #sp^"s"$
}
#let dec(d, m, s) = {
  let mp = _pad-num(m, digits: 2)
  let sp = _pad-num(s, digits: 2)
  $#d^degree\, #mp'\, #sp''$
}
#let object(name, id: none) = link(
  "https://simbad.cds.unistra.fr/simbad/sim-id?Ident=" + if id == none { name } else { id },
  name,
)
#let cfeh = $["Fe"/"H"]$
#let diff = $dif$
#let cint = math.op(math.integral.cont)
#let vdag = $(v)^dagger$

// --- Figuras ---
#let missing-figure(width: 100%, height: 4cm, body) = {
  // Same setup as _todo to show up in the todo-list
  context {
    let sup = t(text.lang, "todos")
    show figure.where(kind: "todo"): it => {}
    let swatch = box(width: 0.6em, height: 0.6em, fill: luma(230), stroke: 0.5pt + black, baseline: 10%)
    figure(kind: "todo", supplement: sup, numbering: none, caption: [#swatch#h(0.4em)#body], none)
  }
  rect(width: width, height: height, fill: luma(230), align(center + horizon)[
    #stack(dir: ltr, spacing: 1em)[
      #box(width: 20pt, height: 20pt, baseline: 50%)[
        #polygon(fill: rgb(255, 128, 0), (10pt, 0pt), (20pt, 20pt), (0pt, 20pt))
        #place(center + horizon, text(fill: white, weight: "bold", size: 12pt, "!"), dy: 2pt)
      ]
    ][
      #body
    ]
  ])
}
#let subfig(img, width: 100%, caption: none) = box(width: width, {
  set align(center)
  block(width: 100%, img)
  if caption != none {
    v(0.3em)
    text(size: 11pt, caption)
  }
})
// Una fila de subfiguras centradas (como \gridline de AASTeX); varias llamadas seguidas forman una grilla.
#let gridline(..figs) = block(width: 100%, align(center, stack(dir: ltr, spacing: 2em, ..figs.pos())))
