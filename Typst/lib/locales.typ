// [UC-TeX] Textos fijos en español e inglés (desde LaTeX/Config/Locales).
// Uso: t(lang, "abstract"); los pares (singular, plural) se eligen con tn(lang, "student", n).

#let strings = (
  es: (
    abstract: "Resumen",
    keywords: "Palabras clave",
    references: "Referencias",
    figure: "Figura",
    figures: "Figuras",
    table: "Tabla",
    tables: "Tablas",
    code: "Código",
    note: "Nota",
    appendix: "Apéndice",
    appendixes: "Apéndices",
    contents: "Contenidos",
    acknowledgments: "Agradecimientos",
    contribution: "Contribuciones",
    facilities: "Lugares",
    software: "Software",
    softwarecode: "Código Usado",
    softwareai: "Uso de IA",
    dataset: "Datos Empleados",
    todos: "Pendientes",
    and-word: "y",
    lab-date: "Fecha del Laboratorio",
    report-date: "Fecha del Informe",
    of-date: "de",
    subject: "Asignatura",
    student: ("Estudiante", "Estudiantes"),
    professor: ("Profesor", "Profesores"),
    assistant: ("Ayudante", "Ayudantes"),
    months: (
      "enero",
      "febrero",
      "marzo",
      "abril",
      "mayo",
      "junio",
      "julio",
      "agosto",
      "septiembre",
      "octubre",
      "noviembre",
      "diciembre",
    ),
  ),
  en: (
    abstract: "Abstract",
    keywords: "Keywords",
    references: "References",
    figure: "Figure",
    figures: "Figures",
    table: "Table",
    tables: "Tables",
    code: "Listing",
    note: "Note",
    appendix: "Appendix",
    appendixes: "Appendixes",
    contents: "Contents",
    acknowledgments: "Acknowledgments",
    contribution: "Author contributions",
    facilities: "Facilities",
    software: "Software",
    softwarecode: "Code Used",
    softwareai: "AI Usage",
    dataset: "Data Used",
    todos: "To do",
    and-word: "and",
    lab-date: "Lab Date",
    report-date: "Report Date",
    of-date: "of",
    subject: "Subject",
    student: ("Student", "Students"),
    professor: ("Professor", "Professors"),
    assistant: ("Assistant", "Assistants"),
    months: (
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ),
  ),
)

#let t(lang, key) = strings.at(lang, default: strings.es).at(key)

// Singular si n == 1, plural en otro caso.
#let tn(lang, key, n) = t(lang, key).at(if n == 1 { 0 } else { 1 })

// "27 de noviembre, 2026" / "November 27, 2026"
#let format-date(lang, d) = {
  let month = t(lang, "months").at(d.month() - 1)
  if lang == "en" [#month #d.day(), #d.year()] else [#d.day() #t(lang, "of-date") #month, #d.year()]
}
