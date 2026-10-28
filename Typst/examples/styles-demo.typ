#import "../lib/template.typ": *

#let styles = ("default", "twocolumn", "preprint", "preprint2", "manuscript", "modern")

#for s in styles {
  show: report.with(
    style: s,
    cover: "short",
    title: "Demo de Estilo: " + s,
    authors: (
      (name: "Autor 1", orcid: none, email: none, affiliation: none),
      (name: "Autor 2", orcid: none, email: none, affiliation: none),
    ),
    abstract: [Este es un abstract para el estilo #s. Muestra el comportamiento del formato de la página, el tamaño de la letra base y los espacios. Las figuras, tablas y referencias mantienen una apariencia consistente en todos los estilos.],
    lang: "es"
  )

  [
    = Sección de Prueba para #s

    Este es el cuerpo del texto para el estilo `#s`. Comprobaremos que las columnas, el tamaño de letra base y el espaciado son correctos de acuerdo a la configuración.

    == Subsección 1

    Aquí va un segundo párrafo. Como se puede ver, el estilo de los títulos se adapta también según el `base_size` en relación al documento principal.
  ]
}
