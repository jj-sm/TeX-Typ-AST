// [UC-TeX] Documento principal. Los datos de portada van en input.typ;
// aquí solo se escribe el contenido.

#import "lib/template.typ": *
#import "input.typ": info

#show: report.with(
  ..info,
  abstract: include "pages/doc/abstract.typ",
  keywords: (
    uat("Galaxies", 573),
    uat("Cosmology", 343),
    uat("High Energy astrophysics", 739),
    uat("Interstellar medium", 847),
    uat("Stellar astronomy", 1583),
    uat("Solar physics", 1476)
  ),
)

// =============================================== MAIN CONTENT ====================================================

#include "pages/sections/1_objetivos.typ"
#include "pages/sections/2_intro_y_marco_teorico.typ"
#include "pages/sections/3_montaje_experimental.typ"
#include "pages/sections/4_resultados_y_analisis.typ"
#include "pages/sections/5_discuciones.typ"
#include "pages/sections/6_conclusiones.typ"
#include "pages/sections/Template.typ"

// ====================================== ACKNOWLEDGMENT & CONTRIBUTIONS ==========================================

#acknowledgments(
  include "pages/doc/acknowledgments.typ"
)

// #contribution(
//  include "pages/doc/contribution.typ"
// )

// ============================================== FACILITIES ======================================================

#facilities(
  "Laboratorio Física UC"
)

// ================================================ SOFTWARE ======================================================

#software(
  [Python - Jupyter Notebook @jupyter],
  [SciPy (Python) @scipy],
  [Sk-learn (Python) @scikit-learn],
  [LaTeX @1989BAAS...21..780H],
  [TeX Template @Sanchez_Medina_AST-FIZ_TeX_Template_2025]
)

#softwarecode(
  [The code used to perform the analysis in this work is available at: #link("https://github.com/jj-sm")[GitHub]]
)

#softwareai(
  [Describa aquí si utilizó herramientas de IA y para qué (p. ej. revisión de redacción).]
)

#dataset(
  [Los datos usados en este trabajo están disponibles en #link("https://github.com/jj-sm").]
)

// =============================================== REFERENCIAS ====================================================
// [UC-TeX][INPUT] Las referencias van aquí, antes del apéndice (como en Main.tex).
// Para ponerlas al final del documento, borra o comenta esta línea.
#references-here()

// ================================================= APPENDIX =====================================================
#show: appendix

// #include "pages/appendix/information.typ"
// #include "pages/appendix/author.typ"
#include "pages/appendix/tables.typ"
// #include "pages/appendix/lang.typ"

#include "pages/sections/Tasks.typ"
