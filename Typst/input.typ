// ==============================================================================================
// ============================================ INPUT ===========================================
// ==============================================================================================
// [UC-TeX][INPUT] Completa estos datos; main.typ los pasa a la plantilla con report.with(..info).
// Las rutas empiezan con "/" y son relativas a la carpeta Typst/.

#let info = (
  // [UC-TeX][INPUT] Idioma: "es" o "en" (títulos, portada, fechas).
  lang: "es",

  // [UC-TeX][INPUT] Portada: "full" (página de portada) o "short" (título al inicio de la página 1).
  cover: "full",

  // ========================================== PORTADA ==========================================
  // [UC-TeX][INPUT] Logo de la asignatura (ver resources/logos/) y su escala (fracción del ancho).
  logo: "/resources/logos/AST-h-black.png",
  logo-scale: 0.6,

  // [UC-TeX][INPUT] specific-title se usa sola en la portada corta; title es el título completo.
  specific-title: [Análisis de Espectros Estelares],
  title: [Laboratorio 1: Análisis de Espectros Estelares],

  // [UC-TeX][INPUT] Asignatura.
  subject: (code: "AST067", name: [Laboratorio de Astronomía]),

  // [UC-TeX][INPUT] Personas: name, orcid, email, affiliation (usa none si no aplica).
  // Email y afiliación aparecen como nota al pie. Las listas vacías () no se muestran.
  authors: (
    (name: "Juan José Sánchez Medina", orcid: "0009-0005-4685-695X", email: none, affiliation: none),
    (name: "Henrietta Leavitt", orcid: none, email: "henrietta.leavitt@estudiante.uc.cl",
      affiliation: "Pontificia Universidad Católica de Chile"),
    (name: "Stephen Hawking", orcid: none, email: none, affiliation: none),
  ),
  professors: (
    (name: "Isaac Newton", orcid: "0000-0000-0000-0000", email: none, affiliation: none),
  ),
  assistants: (
    (name: "Marie Curie", orcid: none, email: none, affiliation: none),
  ),

  // [UC-TeX][INPUT] Mostrar íconos ORCID con enlace (true / false).
  orcid: true,

  // [UC-TeX][INPUT] Fecha del laboratorio (none para ocultarla, p. ej. en tareas).
  lab-date: [6 de noviembre, 2026],
  // [UC-TeX][INPUT] Fecha del informe: auto = fecha de compilación, o escríbela: [27 de noviembre, 2026].
  report-date: auto,

  // ========================================= ENCABEZADO =========================================
  // [UC-TeX][INPUT] Título y autores cortos para el encabezado de cada página.
  short-title: [Informe Laboratorio 01],
  short-authors: [Grupo 2070],

  // ======================================== REFERENCIAS ========================================
  // [UC-TeX][INPUT] Estilo de citas: "author-year" (Autor et al. 2020) o "numeric" ([1], [2], ...).
  cite-style: "author-year",
  // [UC-TeX][INPUT] Archivo .bib (none mientras no haya referencias).
  bibliography: "/Bibliography.bib",
  // [UC-TeX][INPUT] Referencias en 1 o 2 columnas.
  refs-columns: 2,
)
