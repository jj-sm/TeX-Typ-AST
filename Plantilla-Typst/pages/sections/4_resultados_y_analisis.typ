#import "/lib/template.typ": *

= Resultados y Análisis <sec:resultados>

#lorem(129)

$ 1/2 m v_"top"^2 + m g h_"top" = m g h_"rel" $ <ec:analysis_1>

#lorem(8) @ec:analysis_1 #lorem(8) @ec:v_top #lorem(8) _loop_.

$ v_"top" = sqrt(2 g (h_"rel" - 2 bar(r))) $ <ec:v_top>

#lorem(10) @ec:eq_forces #lorem(10) _loop_.

$ (m v_"top"^2) / bar(r) >= m g => v_"top" >= sqrt(bar(r)g), $ <ec:eq_forces>

#lorem(4) @ec:v_top y @ec:eq_forces, tomando a $h_"top" = 2 bar(r)$, se obtiene la altura mínima teórica de lanzamiento necesaria para completar el _loop_ expresada por la ecuación @ec:min_h.

$ h_"min" = 5/2 bar(r) $ <ec:min_h>

#lorem(129)

#figure(
  image("/resources/img/dcl.png", width: 8cm),
  caption: [#lorem(8)],
) <fig:dcl>

#lorem(4) $h_"min" = 12399.01 " cm"$. #lorem(4) $h^"min"_"exp" = 12093.50 " cm"$.

#deluxetable(
  caption: [#lorem(8)],
  columns: ("c", "c", "c", "c", "c"),
  header: (
    [$h_"rel"$\ (cm)],
    [$bar(v)_"exp"$\ (m/s)],
    [$sigma_(v_"exp")$\ (m/s)],
    [$v_"teo"$\ (m/s)],
    [$v_"error"$\ (%)],
  ),
  rows: (
    ( [3.21], [111], [0.221], [120.2], [12.32] ),
    ( [3.21], [111], [0.221], [120.2], [12.32] ),
    ( [3.21], [111], [0.221], [120.2], [12.32] ),
    ( [3.21], [111], [0.221], [120.2], [12.32] ),
    ( [3.21], [111], [0.221], [120.2], [12.32] ),
  ),
  comments: [#lorem(10)],
) <tab:results>

#lorem(129)

$ v_"top"^2 &= 2g(h_"rel" - 2bar(r)) \
  v_"top"^2 &= 2g h_"rel" - 4g bar(r) \
  (v_"top"(h_"rel"))^2 &= underbrace(2g, m)(h_"rel") - underbrace(4g bar(r), b) $ <ec:v_top_lineal>

#lorem(129)

#figure(
  image("/resources/img/exp_vs_teo_summary_sq_fit.png", width: 8cm),
  caption: [#lorem(8)],
) <fig:vel_normal>

#lorem(129)

== Análisis de Errores <subsec:errors>

#lorem(129)

#figure(
  image("/resources/img/mountain_coaster_energy_combined_2.png", width: 8.5cm),
  caption: [#lorem(8)],
) <fig:comparision>

#lorem(129)
