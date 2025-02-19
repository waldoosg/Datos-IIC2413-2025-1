require 'faker'

Faker::Config.locale = 'es'
# Erase all data
Seguro.destroy_all
Review.destroy_all
Transporte.destroy_all
Hospedaje.destroy_all
Participante.destroy_all
Panorama.destroy_all
Reserva.destroy_all
Agenda.destroy_all
Habitaciones.destroy_all
Usuario.destroy_all
Empleado.destroy_all

dominios = ['turket.com', 'waldo.com', 'marmol.com', 'outlook.com', 'viajes.cl']

# Create 1000 users
1000.times do
  Usuario.create!(
    nombre: Faker::Name.name,
    run: Faker::Number.unique.between(from: 200000, to: 30000000),
    dv: Faker::Number.number(digits: 1),
    correo: Faker::Internet.unique.email(domain: dominios.sample),
    contrasena: Faker::Internet.password,
    telefono_contacto: Faker::Base.unique.regexify(/\+56 (9|2) \d{4} \d{4}/),
    puntos: Faker::Number.between(from: 0, to: 10000)
  )
end

# Create 500 employees
500.times do
  Empleado.create!(
    nombre: Faker::Name.name,
    run: Faker::Number.unique.between(from: 1, to: 30000000),
    dv: Faker::Number.number(digits: 1),
    correo: Faker::Internet.unique.email(domain: 'viajes.cl'),
    contrasena: Faker::Internet.password,
    telefono_contacto: Faker::Base.unique.regexify(/\+56 (9|2) \d{4} \d{4}/),
    jornada: ["Diurno", "Nocturno"].sample,
    contrato: ["Part time", "Full time"].sample,
    isapre: ["Más vida", "Colmena", "Consalud", "Banmédica", "Fonasa"].sample
  )
end

#empleados = Empleado.all
usuarios = Usuario.all

# Create 500 agendas
500.times do
  Agenda.create!(
    etiqueta: ["Vacaciones", "Cena de Trabajo", "Salida con Familia", "Salida con Amigos", "Aniversario"].sample,
    usuario_id: usuarios.sample.id
  )
end

agendas = Agenda.all

4000.times do
  Reserva.create!(
      agenda_id: agendas.sample.id,
      fecha: Faker::Date.between(from: '2025-01-01', to: '2026-12-31'),
      monto: Faker::Number.between(from: 5, to: 1000) * 1000,
      cantidad_personas: Faker::Number.between(from: 1, to: 10)
    )
end

reservas = Reserva.all

empresas_seguros = [ "HDI Seguros S.A.",
  "Liberty Compañía de Seguros Generales S.A.",
  "MAPFRE Compañía de Seguros Generales de Chile S.A.",
  "Renta Nacional Compañía de Seguros Generales S.A.",
  "Seguros Generales Suramericana S.A.",
  "BICE Vida Compañía de Seguros S.A.",
  "MetLife Chile Seguros de Vida S.A.",
  "Consorcio Nacional de Seguros Vida S.A.",
  "Confuturo S.A.",
  "Vida Cámara S.A."]

seguros_viaje = {
  "Seguro de Asistencia Médica" => [
    "Cobertura de gastos médicos por enfermedad o accidente",
    "Evacuación y repatriación sanitaria",
    "Cobertura de medicamentos recetados",
    "Hospitalización y cirugías de emergencia"
  ],
  "Seguro de Cancelación de Viaje" => [
    "Reembolso por cancelación debido a enfermedad, accidente o fallecimiento",
    "Cobertura por cancelaciones debido a desastres naturales o disturbios",
    "Reembolso por cancelaciones laborales imprevistas",
    "Cobertura de penalidades por cambio de vuelo"
  ],
  "Seguro de Equipaje y Efectos Personales" => [
    "Cobertura por pérdida, robo o daño de equipaje",
    "Indemnización por retraso en la entrega de equipaje",
    "Cobertura de artículos electrónicos bajo ciertos límites",
    "Asistencia para reemplazo de documentos de viaje perdidos"
  ],
  "Seguro de Interrupción del Viaje" => [
    "Reembolso de gastos no utilizados por interrupción del viaje",
    "Cobertura de costos adicionales por regreso anticipado",
    "Compensación por imprevistos que obliguen a detener el viaje"
  ],
  "Seguro de Responsabilidad Civil" => [
    "Cobertura por daños a terceros durante el viaje",
    "Gastos legales en caso de demandas civiles",
    "Cobertura de daños a propiedades alquiladas"
  ],
  "Seguro por Demoras en el Viaje" => [
    "Reembolso de gastos adicionales por retrasos en vuelos",
    "Cobertura de alojamiento y alimentación por retrasos prolongados",
    "Indemnización por pérdida de conexiones debido a retrasos"
  ]
}
  
# Create seguros
500.times do
  tipo_seguro = seguros_viaje.keys.sample
  clausulas_seguro = seguros_viaje[tipo_seguro]
  Seguro.create(
    reserva_id: reservas.sample.id,
    usuario_id: usuarios.sample.id,
    empresa: empresas_seguros.sample,
    valor: Faker::Number.between(from: 5, to: 100) * 1000,
    clausula: clausulas_seguro.sample(2).join(", "),
    tipo: tipo_seguro
  )
end

resenas = {
  1 => ["Malo", "Pésimo", "No vuelvo más", "Muy insatisfecho", "Completamente decepcionado"],
  2 => ["Regular", "No lo recomendaría", "Hubo varios problemas", "No me convenció del todo"],
  3 => ["Aceptable", "Servicio regular", "Cumplió con mis expectativas, pero sin destacar", "Podría mejorar"],
  4 => ["Bueno", "Me atendieron bien", "Satisfecho, pero hay detalles por mejorar", "Buena experiencia en general"],
  5 => ["Excelente", "Superó mis expectativas", "Muy satisfecho", "Sin duda volveré", "Servicio de primera"]
}

# Create 100 reviews
10000.times do
  estrellas = Faker::Number.between(from: 1, to: 5)
  comentario = resenas[Faker::Number.between(from: 1, to: 5)]
  Review.create(
    reserva_id: reservas.sample.id,
    usuario_id: usuarios.sample.id,
    estrellas: estrellas,
    descripcion: comentario.sample
  )
end


# Create 100 bus
añadir fecha salida o llegada
100.times do
  Buses.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 1, to: 100),
    tiempo_estimado: Faker::Number.between(from: 120, to: 4320),
    precio_asiento: Faker::Number.between(from: 5000, to: 200000),
    empresa: Faker::Company.name,
    tipo: ["Cama", "Semi-cama", "Normal"].sample,
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  )
end

# Create 100 avion
100.times do
  Aviones.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 1, to: 100),
    tiempo_estimado: Faker::Number.between(from: 1, to: 4320),
    precio_asiento: Faker::Number.between(from: 5000, to: 200000),
    empresa: Faker::Company.name,
    clase: ["Primera clase", "Clase ejecutiva", "Clase económica"].sample,
    escalas: Array.new(Faker::Number.between(from: 0, to: 5)) { Faker::Address.city }
  )
end

# Create 100 tren
100.times do
  Trenes.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 1, to: 100),
    tiempo_estimado: Faker::Number.between(from: 1, to: 4320),
    precio_asiento: Faker::Number.between(from: 5000, to: 200000),
    empresa: Faker::Company.name,
    paradas: Array.new(Faker::Number.between(from: 0, to: 5)) { Faker::Address.city },
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  )
end

# Create 1000 Panoramas
  1000.times do
  Panorama.create(
    reserva_id: reservas.sample.id,
    empresa: Faker::Company.name,
    nombre_panorama: ["Tour", "Paseo", "Excursión", "Visita", "Aventura"].sample,
    descripcion: ["Disfruta de un día en la naturaleza", "Conoce la historia de la ciudad", "Aventúrate en la montaña", "Descubre la gastronomía local", "Relájate en la playa"].sample,
    ubicacion: Faker::Address.city,
    duracion: Faker::Number.between(from: 1, to: 7),
    precio_persona: Faker::Number.between(from: 5000, to: 100000),
    capacidad: Faker::Number.between(from: 1, to: 100),
    restricciones: ["No apto para menores de 18 años", "No apto para personas con movilidad reducida", "No apto para personas con problemas de salud", "No apto para personas con problemas de movilidad"].sample
  )
end

panoramas = Panorama.all;
# Create 10000 participantes
10000.times do
  Participante.create(
    panorama_id: panoramas.sample.id,
    nombre_participante: Faker::Name.name,
  )
end

# Create 2000 Hospedajes
2000.times do
  Hoteles.create(
    reserva_id: reservas.sample.id,
    nombre_hospedaje: Faker::Company.name,
    ubicacion: Faker::Address.city,
    precio_noche: Faker::Number.between(from: 5000, to: 150000),
    estrellas: Faker::Number.between(from: 1, to: 5),
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3),
    disponibilidad: Faker::Boolean.boolean,
    politicas: ["No se permiten mascotas", "No se permite fumar", "No se permiten fiestas", "No se permiten visitas"].sample(2)
  )
end

# Create 2000 Airbnb
2000.times do
  Airbnb.create(
    reserva_id: reservas.sample.id,
    nombre_hospedaje: Faker::Company.name,
    ubicacion: Faker::Address.city,
    precio_noche: Faker::Number.between(from: 5000, to: 150000),
    estrellas: Faker::Number.between(from: 1, to: 5),
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3),
    disponibilidad: Faker::Boolean.boolean,
    nombre_anfitrion: Faker::Name.name,
    contacto_anfitrion: Faker::Base.regexify(/\+56 (9|2) \d{4} \d{4}/),
    descripcion: ["Disfruta de una estadía en el corazón de la ciudad", "Relájate en un lugar tranquilo y acogedor", "Descubre la historia de la ciudad desde tu ventana", "Aventúrate en la naturaleza y descansa en un lugar cómodo"].sample,
    piezas: Faker::Number.between(from: 1, to: 6),
    camas: Faker::Number.between(from: 1, to: 6),
    banos: Faker::Number.between(from: 1, to: 4)
  )
end

hoteles = Hoteles.all;

# Create 40000 habitaciones
40000.times do
  Habitaciones.create(
    hotel_id: hoteles.sample.id,
    numero_habitacion: Faker::Number.unique.between(from: 1, to: 50000),
  )
end

puts "Se crearon exitosamente 🎉🎉✨✨🎉🎉"

