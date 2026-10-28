// [UC-TeX] Vista previa de la esfera celeste (equivalentes a Resources/tikz/output/{all,lat,alt}.pdf).
// typst compile --root Typst Typst/resources/cetz/celestial-sphere-demo.typ
#import "celestial-sphere.typ": celestial-sphere
#set page(width: auto, height: auto, margin: 5mm)
#set text(font: "New Computer Modern", size: 12pt)

#celestial-sphere() // all
#pagebreak()
#celestial-sphere(show-alt: false) // lat
#pagebreak()
#celestial-sphere(show-lat: false) // alt
#pagebreak()
#celestial-sphere(lat: -33.4deg, site: "SCL") // Santiago: polo sur elevado
#pagebreak()
#block(width: 8cm, celestial-sphere(width: 100%)) // escalado al ancho
