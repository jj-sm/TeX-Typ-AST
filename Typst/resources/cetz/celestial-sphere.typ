// [UC-TeX] Esfera celeste en CeTZ (reemplaza LaTeX/Resources/tikz/celestial_sphere.tex).
//
// Uso:
//   #import "/resources/cetz/celestial-sphere.typ": celestial-sphere
//   #figure(celestial-sphere(lat: 4deg, site: "BOG", width: 80%), caption: [...])
//
// Toda la geometría sale de la latitud del lugar (`lat`, positiva al norte): eje polar, ecuador
// celeste, altura del ecuador h_eq = 90° − |lat| y ángulo del polo elevado φ = |lat|.
//   show-lat: false -> solo la altura del ecuador (como output/alt.pdf)
//   show-alt: false -> solo la latitud            (como output/lat.pdf)

#import "@preview/cetz:0.5.3": canvas, draw

#let _blue = rgb("#0000ff")
#let _green = rgb("#00ff00")
#let _cyan = rgb("#00aeef")
#let _red = rgb("#ff0000")

// --- Vectores 3D ---
#let _add(a, b) = a.zip(b).map(((x, y)) => x + y)
#let _mul(a, k) = a.map(x => x * k)
#let _dot(a, b) = a.zip(b).map(((x, y)) => x * y).sum()
#let _cross(a, b) = (
  a.at(1) * b.at(2) - a.at(2) * b.at(1),
  a.at(2) * b.at(0) - a.at(0) * b.at(2),
  a.at(0) * b.at(1) - a.at(1) * b.at(0),
)
#let _unit(a) = _mul(a, 1 / calc.sqrt(_dot(a, a)))

#let celestial-sphere(
  lat: 4deg,
  site: "BOG",
  show-lat: true,
  show-alt: true,
  lat-label: auto,
  alt-label: auto,
  radius: 3,
  view: (phi: 4deg, theta: 80deg),
  width: auto,
) = {
  let R = radius
  let (vp, vt) = (view.phi, view.theta)
  let north = lat >= 0deg
  let lat-abs = calc.abs(lat)
  let h-eq = 90deg - lat-abs
  let deg-num(a) = calc.round(a.deg(), digits: 1)
  let lat-label = if lat-label == auto [$#deg-num(lat-abs)°$ #if north [N] else [S]] else { lat-label }
  let alt-label = if alt-label == auto [$#deg-num(h-eq)°$ #site] else { alt-label }

  // Proyección ortográfica igual a `3d/install view={phi, theta}` de tikz-3dtools.
  let proj(p) = {
    let (x, y, z) = p
    (
      x * calc.cos(vp) + y * calc.sin(vp),
      -x * calc.cos(vt) * calc.sin(vp) + y * calc.cos(vt) * calc.cos(vp) + z * calc.sin(vt),
    )
  }
  let depth(p) = {
    let (x, y, z) = p
    x * calc.sin(vt) * calc.sin(vp) - y * calc.sin(vt) * calc.cos(vp) + z * calc.cos(vt)
  }
  let off(p, angle, d) = _add(proj(p), (d * calc.cos(angle), d * calc.sin(angle)))

  // Círculo máximo de normal n: parte delantera continua, trasera segmentada.
  let great-circle(n, color) = {
    let n = _unit(n)
    let a = if calc.abs(n.at(2)) < 0.9 { (0, 0, 1) } else { (1, 0, 0) }
    let u = _unit(_cross(n, a))
    let v = _cross(n, u)
    let pts = range(0, 361, step: 2).map(k => {
      let t = k * 1deg
      _add(_mul(u, R * calc.cos(t)), _mul(v, R * calc.sin(t)))
    })
    let runs = ()
    let run = (pts.first(),)
    for i in range(1, pts.len()) {
      let p = pts.at(i)
      if (depth(p) >= 0) == (depth(pts.at(i - 1)) >= 0) {
        run.push(p)
      } else {
        run.push(p)
        runs.push(run)
        run = (p,)
      }
    }
    runs.push(run)
    for r in runs {
      let front = depth(r.at(calc.div-euclid(r.len(), 2))) >= 0
      let stroke = if front { (paint: color, thickness: 0.5pt) } else {
        (paint: color, thickness: 0.3pt, dash: "dashed")
      }
      draw.line(..r.map(proj), stroke: stroke)
    }
  }

  // Ángulo en el plano de la pantalla entre los rayos O->a y O->b (como el pic `angle` de TikZ).
  let screen-angle(p) = { let (x, y) = proj(p); calc.atan2(x, y) }
  let arc-points(a, b, r) = {
    let (t1, t2) = (screen-angle(a), screen-angle(b))
    let d = t2 - t1
    if d > 180deg { d -= 360deg }
    if d < -180deg { d += 360deg }
    range(0, 41).map(k => {
      let t = t1 + d * k / 40
      (r * calc.cos(t), r * calc.sin(t))
    })
  }
  // Punto a una fracción del ángulo (0 = rayo a, 1 = rayo b).
  let along(a, b, dist, frac) = arc-points(a, b, dist).at(int(calc.round(frac * 40)))
  let angle-layer(a, b, color, sector-r, sector-label, arc-label) = {
    draw.line((0, 0), ..arc-points(a, b, sector-r), close: true,
      fill: color.lighten(80%).transparentize(50%), stroke: (paint: color.lighten(50%), thickness: 0.4pt))
    draw.line(..arc-points(a, b, R), stroke: (paint: color, thickness: 1.5pt))
    // Ángulos chicos: etiquetas bajo el rayo del horizonte para que no se tapen.
    let small = calc.abs(screen-angle(a) - screen-angle(b)) < 20deg
    if small {
      draw.content(_add(along(a, b, sector-r, 0.5), (0, -0.25)), sector-label)
      draw.content(_add(along(a, b, R * 0.33, 0.5), (0, -0.25)), arc-label)
    } else {
      draw.content(along(a, b, sector-r * 0.72, 0.35), sector-label)
      draw.content(along(a, b, R * 0.72, 0.5), arc-label)
    }
  }

  // --- Puntos ---
  let O = (0, 0, 0)
  let S = (R, 0, 0)
  let N = (-R, 0, 0)
  let E = (0, R, 0)
  let W = (0, -R, 0)
  let Z = (0, 0, R)
  let Zp = (0, 0, -R)
  let axis = (-calc.cos(lat), 0, calc.sin(lat)) // hacia el NCP
  let NCP = _mul(axis, 1.5 * R)
  let SCP = _mul(axis, -1.5 * R)
  let EQC = (R * calc.sin(lat), 0, R * calc.cos(lat)) // cruce del ecuador con el meridiano, sobre el horizonte
  let pole-up = _mul(axis, if north { R } else { -R }) // polo elevado, sobre la esfera
  let (h-pole, h-eqside) = if north { (N, S) } else { (S, N) }

  let drawing = canvas(length: 1cm, {
    draw.circle((0, 0), radius: R, stroke: 0.7pt)
    great-circle((0, 0, 1), _green)
    great-circle(axis, _blue)

    if show-alt {
      draw.line((0, 0), proj(EQC), stroke: (paint: _cyan, thickness: 1.5pt, dash: "dotted"))
      draw.line((0, 0), proj(h-eqside), stroke: (paint: _cyan, thickness: 2pt, dash: "dotted"))
      angle-layer(h-eqside, EQC, _cyan, 1.5, $h_(e q)$, alt-label)
    }
    if show-lat {
      draw.line((0, 0), proj(h-pole), stroke: (paint: _green, thickness: 2pt, dash: "dotted"))
      angle-layer(h-pole, pole-up, _green, 1.7, $phi.alt$, lat-label)
    }

    draw.line(proj(SCP), proj(NCP), stroke: (paint: _blue, thickness: 0.5pt))
    draw.content(off(NCP, 200deg, 0.5), [NCP])
    draw.content(off(SCP, 20deg, 0.5), [SCP])
    for p in (NCP, SCP) { draw.circle(proj(p), radius: 0.4pt, fill: _blue, stroke: none) }

    draw.circle((0, 0), radius: 2pt, fill: _blue, stroke: 0.4pt)
    for (p, a, d, l) in (
      (S, 0deg, 0.3, [S]),
      (N, 180deg, 0.3, [N]),
      (O, -90deg, 0.3, [O]),
      (W, 240deg, 0.4, [W]),
      (E, 50deg, 0.3, [E]),
      (Z, 90deg, 0.3, [Z]),
      (Zp, -90deg, 0.3, [Z′]),
    ) {
      draw.content(off(p, a, d), l)
      draw.circle(proj(p), radius: 1.2pt, fill: black, stroke: none)
    }
    draw.circle(proj(EQC), radius: 2pt, fill: _red, stroke: 0.4pt)
  })

  if width == auto { return drawing }
  layout(size => {
    let w = if type(width) == ratio { width * size.width } else { width }
    let m = measure(drawing)
    scale(w / m.width * 100%, reflow: true, drawing)
  })
}
