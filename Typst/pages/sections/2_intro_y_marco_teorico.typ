#import "/lib/template.typ": *

= Introducción y Marco Teórico <sec:intro>

== Energía <subsec:energy>

#lorem(129) @resnick_physics.

=== Energía Cinética <subsubsec:kinetic>

#lorem(129) @ec:kinetic_e. Donde $m$ es la masa del carro y $v$ su velocidad @resnick_physics.

$ K = 1/2 m v^2 $ <ec:kinetic_e>

=== Energía Potencial Gravitatoria <subsubsec:potential>

#lorem(8) @ec:mgh. #lorem(8) ($m$) y la altura ($h$) del cuerpo @Kleppner.

$ U = m g h $ <ec:mgh>

#lorem(10) @resnick_physics.

=== Energía Mecánica <subsubsec:mechanic_e>

#lorem(4) @ec:total_e @resnick_physics.

$ E = K + U $ <ec:total_e>

#lorem(8)

=== Conservación de la Energía <subsubsec:energy_conservation>

#lorem(8) @Kleppner.

$ K_i + U_i = K_f + U_f = E $ <ec:conservation_e>

#lorem(8)

#figure(
  image("/resources/img/energy_linear_unitless.png", width: 8.5cm),
  caption: [Ejemplo de conservación de la energía. Los datos se encuentran normalizados.],
) <fig:energy_linear>

== Fuerzas <subsec:forces>

=== Teorema Trabajo-Energía <subsubsec:work_energy_teo>

#lorem(129) @Kleppner. Este teorema permite analizar sistemas dinámicos considerando únicamente las fuerzas que actúan sobre estos.

$ W_{b -> a} = #cint^a_b bold(F) dot #diff bold(r) $ <ec:work_energy>

$ W_{b -> a} = Delta E $ <ec:work_energy_2>

#lorem(8)

=== Movimiento Circular <subsubsec:circular_mov>

#lorem(80)

$ bold(a)_c = (v^2) / r hat(bold(r)) $ <ec:c_accel>

#lorem(129)

$ bold(F)_c = m bold(a)_c = m (v^2)/r hat(bold(r)) $ <ec:f_c>

#lorem(129)

$ bold(F)_(c f) = - m (v^2)/r hat(bold(r)) $ <ec:f_cf>
