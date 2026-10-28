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
Puedes comenzar a trabajar desde el `.zip` en los últimos _releases_ [aquí](https://github.com/jj-sm/TeX-AST/releases/download/v1.0/TeX-ASTFIZ.zip).

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

## Publicar release de Plantilla

El repositorio incluye el workflow [.github/workflows/release-plantilla.yml](.github/workflows/release-plantilla.yml), que empaqueta el contenido de `Plantilla/` (excluyendo `Plantilla/.gitignore`) y lo sube como asset de un release.

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
2. Abrir el workflow `Release Plantilla on Tag`.
3. Click en `Run workflow`.
4. Opcional: indicar `tag_name` (debe iniciar con `v`, por ejemplo `v1.0.1`).

El archivo adjunto al release se llama `Plantilla-<tag>.zip`.


Made with ❤️ by [jj-sm](https://www.linkedin.com/in/jj-sm/)

