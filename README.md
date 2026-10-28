# Plantilla TeX - Informes/Labs AST/FIZ

Plantilla para informes y laboratorios de estudiantes de la Pontificia Universidad Católica de Chile enfocada en especial para ramos de FIZ y AST. Basada en [AASTeXv7](https://github.com/AASJournals/AASTeX7)

>[!NOTE]
> (27/Dic/2025) Ahora disponible en inglés y español, junto a mejoras menores.
>
> (27/Oct/2026) Portada con correo y afiliación por autor (`{ORCID}{Nombre}{Correo}{Afiliación}`), fecha de laboratorio opcional y portada corta para tareas (`Pages/Doc/short_cover.tex`); referencias a una o dos columnas (`\onecolumnrefstrue`); nuevos bloques `\softwareai` y `\dataset`; macros de astronomía (`\ra`, `\dec`, unidades, enlaces a SIMBAD con `\object`); estilos de código Python y ADQL (`Config/Listings/`); estilo bibliográfico opcional `aasjournalv7.1.bst` con títulos de artículos.

> Disclamer 1: En lo posible dar créditos a la plantilla como modificación de AASTeXv7 por [jj-sm](https://github.com/jj-sm/)

> Disclamer 2: El uso de la plantilla no está ligado oficialmente a la UC, consulte con su curso si está permitido y **verifique** si esta plantilla cumple con las normas de estilo de su informe.

>[!NOTE]
>- Se usa `pdfTeX` para compilar el documento.
>- Se usa el estilo bibliográfico para citas de **AAS Journals**, el cual se encuentra en `../Config/NoMod/aasjournalv7.bst` y puede ser reemplazado. En caso tal referenciarlo al final del documento principal.

## LaTeX o Typst

A partir de la versión 3.0.0, la plantilla está disponible en dos formatos que pueden ser usados indistintamente y producen resultados casi idénticos:

* **LaTeX (`LaTeX/`)**: La versión clásica basada en AASTeXv7. Recomendada si ya estás acostumbrado a LaTeX, necesitas usar paquetes de LaTeX específicos o estás editando en Overleaf.
* **Typst (`Typst/`)**: Una versión moderna escrita en [Typst](https://typst.app/). Typst compila instantáneamente, tiene una sintaxis más limpia y mensajes de error mucho más claros. Recomendada para nuevos usuarios, informes rápidos o si quieres compilar localmente sin instalar una distribución pesada de LaTeX.

---

### Versión Typst

**Requisitos**: Typst 0.15.0 o superior.

**Compilación y uso local**:
Puedes usar Typst a través de su [Web App](https://typst.app/) o localmente. Para uso local:
1. Instala Typst (`brew install typst`, `cargo install typst-cli`, o descarga los binarios).
2. Desde la raíz de esta plantilla, ejecuta el comando para compilar el PDF:
   ```bash
   typst compile Typst/main.typ
   ```
3. O usa el modo de observación para recompilar automáticamente cada vez que guardes el archivo:
   ```bash
   typst watch Typst/main.typ
   ```

**Configuración (`input.typ`)**:
El archivo `input.typ` contiene la configuración principal del documento que puedes ajustar:
* `lang`: Idioma del documento (`"es"` o `"en"`).
* `cover`: Tipo de portada (`"full"` para portada completa, `"short"` para título corto).
* `logo` / `logo-scale`: Ruta al logo de la universidad o facultad y su escala.
* `title` / `specific-title`: Título principal y específico de la portada.
* `subject`: Código y nombre de la asignatura (`code`, `name`).
* `authors`, `professors`, `assistants`: Listas de personas involucradas. Cada persona es un diccionario con `name`, `orcid`, `email`, y `affiliation`.
* `orcid`: Mostrar o no el ícono ORCID enlazado.
* `lab-date` / `report-date`: Fecha del laboratorio y fecha de entrega.
* `short-title` / `short-authors`: Encabezados de página para páginas pares e impares.
* `cite-style`: Estilo de citas (`"author-year"` o `"numeric"`).
* `bibliography`: Ruta al archivo `.bib` (ej. `"/Bibliography.bib"`).
* `refs-columns`: Número de columnas para las referencias (1 o 2).

**Helpers y Funciones útiles (API)**:
Puedes llamar a estas funciones en cualquier parte del documento:
* `references-here()`: Inserta la bibliografía en la posición actual en lugar de al final.
* `citet("key")`, `citep("key")`: Citas textuales y parentéticas.
* `#show: appendix`: Inicia la sección de apéndices.
* `deluxetable(caption: none, columns: (), header: (), rows: (), comments: none, wide: false)`: Tabla con formato AASTeX. Usa `headgroup[..]` dentro de `rows` para una fila de grupo que abarca todas las columnas.
* Cajas de comentarios (TODOs): `todo-error[..]`, `todo-warn[..]`, `todo-remark[..]`, `todo-hint[..]`, `todo-done[..]`, `todo-short[..]`, y `#todo-list()` para listar todos los pendientes.
* Metadatos y software: `facilities(..)`, `software(..)`, `softwarecode(..)`, `softwareai(..)`, `dataset(..)`.
* Astronomía: `ra(h, m, s)`, `dec(d, m, s)`, `object("name")` (enlace a SIMBAD), `cfeh`, `qty`, `num`, `unit` (usando el paquete `unify`).
* Figuras: `gridline(..figs)` para grillas de figuras, `subfig(img, width, caption)` para subfiguras, `missing-figure[texto]`.
* TikZ/Esfera celeste: `celestial-sphere(..)` importando de `resources/cetz/celestial-sphere.typ`.

---

## Vista General

Esta plantilla permite hacer de manera dinámica informes _formateados_ en $\LaTeX$ bajo la plantilla inicial proporcionada por [AASTeXv7](https://journals.aas.org/aastex-package-for-manuscript-preparation/#_download); por este motivo, todos los comandos básicos de `AASTeXv7` funcionan en esta plantilla. Para ver información acerca de estos comandos, dirigete a la guía de [_AASTeXv7 Guide_](https://journals.aas.org/aastexguide/).

El `.zip` inicial ya cuenta con los logos base, donde se encuentran logos de FIZ, AST y la UC. El archivo principal es `Informe.tex` y se recomienda leer los comentarios de manera secuencial y descubrir las múltiples opciones disponibles.

<p align="center">
<img width="1134" alt="image" src="https://github.com/user-attachments/assets/53642133-78fb-4ee4-9405-7c6b5b5b1b85" />
</p>

<p align="center">
<img width="1133" alt="image" src="https://github.com/user-attachments/assets/49c6ab83-9f36-4e0e-a5d1-7876a4e16187" />
</p>

Además, bajo la carpeta de `tikz` incluye soporte para la creación de esferas celestes (gracias a la librería de [https://github.com/marmotghost/tikz-3dtools](https://github.com/marmotghost/tikz-3dtools)).
<p align="center">
<img width="525" alt="Screenshot 2025-04-30 at 1 53 28 PM" src="https://github.com/user-attachments/assets/d081c72d-07cc-4508-87cf-6e7c081e808c" />
</p>


## Instalación
Descarga el `.zip` del último _release_ [aquí](https://github.com/jj-sm/TeX-Typ-AST/releases/latest): `TeX-AST-Template-<versión>.zip` (LaTeX) o `Typ-AST-Template-<versión>.zip` (Typst).

>[!CAUTION]
> En el caso de usar overleaf, y querer trabajar con las esferas celestes, te recomendamos que descargues la carpeta que contiene al `.tex` de las esferas celestes (verificando que incluyas al `>>.code.tex` y compilar cada figura por aparte para luego agregarlas a la carpeta output y poder ser usadas en el documento principal.
>
> Se recomienda el uso de vscode para editar esta plantilla más fácilmente.

## Uso
Se han agregado nuevas funciones para adaptar esta plantilla correctamente a un uso en la UC. Por defecto, se agregaron comentarios en campos donde se espera que se ingresen los datos propios del documento, estos campos estarán señalados con el tag: `%% [UC-TeX][INPUT]`. Además, los comentarios que comiencen con `%% [UC-TeX]` indican un cambio por parte del equipo, mientras que los comentarios `%% [AASTeX]` indican el archivo y comentarios originales. 

>[!NOTE]
> Encontrarás un archivo llamado `input.tex` donde se deben llenar ciertos datos. Además hay que revisar el archivo `main.tex` donde allí se tienen que llenar el resto de información donde cada sección está denotada con un separador `=====`. 

La plantilla cuenta con la siguiente estructura:

```text
├── InformesTex-Plantilla
│   ├── aastex7.cls <--------------------------* Estilo de AASTeX
│   ├── Config
│   │   ├── authors.tex <----------------------- Archivo donde se incluyen los autores (en caso de no usar cover.tex)
│   │   ├── keywords.tex <---------------------- Archivo donde se incluyen las keywords
│   │   └── NoMod
│   │       └── aasjournalv7.bst <-------------* Estilo Bibliográfico de AASTeX
│   ├── Informe.pdf <--------------------------- PDF de salida
│   ├── Informe.tex <--------------------------- Archivo TeX principal
│   ├── Pages
│   │   ├── Appendix <-------------------------- Directorio donde se incluyen los apéndices ...
│   │   │   ├── author.tex 
│   │   │   ├── ...
│   │   ├── Doc
│   │   │   ├── abstract.tex <------------------ Abstract del documento
│   │   │   ├── acknowledgments.tex <----------- Reconocimientos del documento
│   │   │   ├── contribution.tex <-------------- Contribuciones del documento
│   │   │   └── cover.tex <--------------------- Portada del documento, modificar a conveniencia (sin modificar los comandos)
│   │   └── Sections <-------------------------- Directorio de las secciones (Cuerpo del documento)
│   │       ├── preguntas.tex
│   │       └── ....tex
│   └── Resources
│       ├── img <------------------------------- Directorio para incluir imágenes y figuras
│       │   └── image2.png
│       ├── logos <----------------------------- Directorio para incluir nuevos logos
│       │   ├── AST-center-black.png
│       │   ├── AST-center-color.jpg
│       │   └── ...
│       ├── misc <-----------------------------* Archivos de soporte para el documento
│       │   └── orcid-ID.png
│       └── tikz <------------------------------ Figuras con tikz y esfera celeste
│           ├── celestial_sphere.pdf
│           ├── celestial_sphere.tex 
│           ├── output
│           │   ├── all.pdf
│           │   └── ...
│           └── tikzlibrary3dtools.code.tex <--* Librería para crear esferas celestes
```

Las indicaciones marcadas con: `<--*` indican que ese archivo o directorio no debe ser modificado.

## Contribuir
Se recibe feedback, contribuciones, PRs; ¡todo es bienvenido!

## Publicar un release

El repositorio incluye el workflow [.github/workflows/release-plantilla.yml](.github/workflows/release-plantilla.yml), que empaqueta `LaTeX/` y `Typst/` (sin `.gitignore` ni PDFs generados en `Typst/`) y los sube como assets de un release.

Disparadores disponibles:

1. Push de tags que comiencen con `v` (por ejemplo `v1.0.0`).
2. Ejecución manual desde la pestaña Actions (`workflow_dispatch`).

Para release automático con tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Para release manual:

1. Ir a Actions.
2. Abrir el workflow `Release on Tag`.
3. Click en `Run workflow`.
4. Opcional: indicar `tag_name` (debe iniciar con `v`, por ejemplo `v1.0.1`).

El release se llama `TeX-Typ-AST <tag>` y adjunta `TeX-AST-Template-<tag>.zip` (LaTeX) y `Typ-AST-Template-<tag>.zip` (Typst).

## Licencias

* El código general de este repositorio, incluyendo `Typst/`, está cubierto por la licencia especificada en `LICENSE`.
* Los estilos de citas (`Typst/styles/*.csl`) provienen del proyecto CSL y están bajo la licencia CC BY-SA 3.0.
* Los paquetes de Typst Universe usados (como `@preview/cetz` y `@preview/unify`) son descargados al momento de compilar y tienen sus propias licencias.

Made with ❤️ by [jj-sm](https://www.linkedin.com/in/jj-sm/)

