require 'faker'

Faker::Config.locale = 'es'
# Erase all data
Habitaciones.destroy_all
Seguro.destroy_all
Review.destroy_all
Transporte.destroy_all
Hospedaje.destroy_all
Participante.destroy_all
Panorama.destroy_all
Reserva.destroy_all
Agenda.destroy_all
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

empleados = Empleado.all
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

empresas_buses = [
  "Turbus", "Pullman Bus", "Condor Bus", "EME Bus", "JetSur",
  "Buses Romani", "Buses Nilahue", "Buses Ahumada", "Buses Bio Bio",
  "Flecha Bus", "Chevallier", "Andesmar", "Via Bariloche", "El Rápido Internacional",
  "Plusmar", "Crucero del Norte", "ADO", "Estrella Roja", "Primera Plus",
  "ETN Turistar", "Omnibus de México", "Futura", "Alsa", "Avanza",
  "Socibus", "Monbus", "Damas", "Greyhound", "Megabus",
  "FlixBus", "BoltBus"
]

# Create 100 bus
# añadir fecha salida o llegada
100.times do
  tiempo_estimado = Faker::Number.between(from: 120, to: 720)
  precio_asiento = Faker::Number.between(from: 5, to: 50) * 1000
  tipo = "Normal"

  if tiempo_estimado > 600
    precio_asiento = Faker::Number.between(from: 50, to: 200) * 1000
    tipo = "Cama"
  elsif tiempo_estimado > 480
    precio_asiento = Faker::Number.between(from: 40, to: 150) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 360
    precio_asiento = Faker::Number.between(from: 30, to: 100) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 240
    precio_asiento = Faker::Number.between(from: 20, to: 80) * 1000
    tipo = ["Normal", "Semi-cama"].sample
  end

  Buses.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 30, to: 50),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_buses.sample,
    tipo: tipo,
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  )
end

empresas_aerolineas = [
  "American Airlines", "Delta Air Lines", "United Airlines", "Southwest Airlines",
  "JetBlue", "Alaska Airlines", "Spirit Airlines", "Frontier Airlines",
  "British Airways", "Lufthansa", "Air France", "KLM", "Iberia",
  "LATAM Airlines", "Avianca", "Copa Airlines", "Aeroméxico",
  "Qatar Airways", "Emirates", "Etihad Airways", "Turkish Airlines",
  "Singapore Airlines", "Japan Airlines", "All Nippon Airways (ANA)",
  "Qantas", "Air New Zealand", "Ethiopian Airlines", "Ryanair",
  "EasyJet", "Vueling", "Wizz Air", "Air Canada", "WestJet"
]

# Create 100 avion
100.times do
  tiempo_estimado = Faker::Number.between(from: 120, to: 4320)
  precio_asiento = Faker::Number.between(from: 5, to: 200) * 1000
  clase = ["Clase ejecutiva", "Clase económica"].sample

  if tiempo_estimado > 3600
    precio_asiento = Faker::Number.between(from: 150, to: 500) * 1000
    clase = "Primera clase"
  elsif tiempo_estimado > 2880
    precio_asiento = Faker::Number.between(from: 100, to: 400) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
  elsif tiempo_estimado > 2160
    precio_asiento = Faker::Number.between(from: 80, to: 300) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
  elsif tiempo_estimado > 1440
    precio_asiento = Faker::Number.between(from: 50, to: 200) * 1000
    clase = ["Clase ejecutiva", "Clase económica"].sample
  elsif tiempo_estimado > 720
    precio_asiento = Faker::Number.between(from: 30, to: 150) * 1000
    clase = "Clase económica"
  end

  Aviones.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 1, to: 100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_aerolineas.sample,
    clase: clase,
    escalas: Array.new(Faker::Number.between(from: 0, to: 5)) { Faker::Address.city }
  )
end

empresas_trenes = [
  "Amtrak", "Eurostar", "Thalys", "TGV (SNCF)", "Renfe", "AVE", 
  "Deutsche Bahn (DB)", "Trenitalia", "Italo", "ÖBB (Austria)", 
  "SBB (Suiza)", "Nederlandse Spoorwegen (NS)", "EuroCity", 
  "Shinkansen (Japón)", "JR East", "JR West", "JR Central", 
  "Indian Railways", "China Railway", "KTX (Corea del Sur)", 
  "Via Rail (Canadá)", "Brightline (EE.UU.)", "Rocky Mountaineer", 
  "Great Western Railway (GWR)", "Virgin Trains", "South Western Railway",
  "ScotRail", "TransPennine Express", "West Midlands Trains", 
  "LNER (London North Eastern Railway)"
]

# Create 100 tren
100.times do
  tiempo_estimado = Faker::Number.between(from: 120, to: 4320)
  precio_asiento = Faker::Number.between(from: 5, to: 200) * 1000

  if tiempo_estimado > 3600
    precio_asiento = Faker::Number.between(from: 150, to: 500) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(7)
  elsif tiempo_estimado > 2880
    precio_asiento = Faker::Number.between(from: 100, to: 400) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(6)
  elsif tiempo_estimado > 2160
    precio_asiento = Faker::Number.between(from: 80, to: 300) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(5)
  elsif tiempo_estimado > 1440
    precio_asiento = Faker::Number.between(from: 50, to: 200) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(4)
  elsif tiempo_estimado > 720
    precio_asiento = Faker::Number.between(from: 30, to: 150) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  end

  Trenes.create(
    reserva_id: reservas.sample.id,
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: Faker::Number.between(from: 1, to: 100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_trenes.sample,
    paradas: Array.new(Faker::Number.between(from: 0, to: 5)) { Faker::Address.city },
    comodidades: comodidades
  )
end

empresas_turismo = [
  "TUI Group", "Expedia Group", "Booking Holdings", "Tripadvisor", "CWT",
  "American Express Global Business Travel", "Flight Centre Travel Group", 
  "Travel Leaders Group", "Apple Leisure Group", "BCD Travel", "Thomas Cook",
  "Kuoni", "Abercrombie & Kent", "G Adventures", "Intrepid Travel", 
  "Contiki", "Trafalgar", "Insight Vacations", "Globus", "Exodus Travels", 
  "EF Tours", "National Geographic Expeditions", "Viator", "GetYourGuide",
  "Klook", "Civitatis", "Gray Line", "Secret Escapes", "Luxury Escapes", 
  "Hays Travel"
]
# Create 1000 Panoramas
1000.times do
  Panorama.create(
    reserva_id: reservas.sample.id,
    empresa: empresas_turismo.sample,
    nombre_panorama: ["Tour", "Paseo", "Excursión", "Visita", "Aventura"].sample,
    descripcion: ["Disfruta de un día en la naturaleza", "Conoce la historia de la ciudad", "Aventúrate en la montaña", "Descubre la gastronomía local", "Relájate en la playa"].sample,
    ubicacion: Faker::Address.city,
    duracion: Faker::Number.between(from: 1, to: 7),
    precio_persona: Faker::Number.between(from: 5, to: 100) * 1000,
    capacidad: Faker::Number.between(from: 1, to: 50),
    restricciones: ["No apto para menores de 18 años", "No apto para personas con movilidad reducida", "No apto para personas con problemas de salud", "No apto para personas con problemas de movilidad"].sample
  )
end

panoramas = Panorama.all;
# Create 10000 participantes
10000.times do
  Participante.create(
    panorama_id: panoramas.sample.id,
    nombre_participante: usuarios.sample.nombre,
  )
end

empresas_hoteleras = [
  "Marriott International", "Hilton Hotels & Resorts", "Hyatt Hotels Corporation",
  "InterContinental Hotels Group (IHG)", "Wyndham Hotels & Resorts",
  "AccorHotels", "Choice Hotels International", "Radisson Hotel Group",
  "Four Seasons Hotels & Resorts", "Best Western Hotels & Resorts",
  "Melia Hotels International", "NH Hotel Group", "Rosewood Hotels & Resorts",
  "Fairmont Hotels & Resorts", "The Ritz-Carlton", "Mandarin Oriental",
  "Shangri-La Hotels and Resorts", "Belmond", "Loews Hotels",
  "Omni Hotels & Resorts", "Drury Hotels", "Red Lion Hotels Corporation",
  "Sonesta International Hotels", "MGM Resorts International",
  "Caesars Entertainment", "Hard Rock Hotels", "Kimpton Hotels & Restaurants",
  "Aman Resorts", "Six Senses Hotels Resorts Spas"
]

# Create 2000 Hospedajes
2000.times do
  Hoteles.create(
    reserva_id: reservas.sample.id,
    nombre_hospedaje: empresas_hoteleras.sample,
    ubicacion: Faker::Address.city,
    precio_noche: Faker::Number.between(from: 5, to: 150) * 1000,
    estrellas: Faker::Number.between(from: 1, to: 5),
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación"].sample(5),
    disponibilidad: [true, false].sample,
    politicas: ["No se permiten mascotas", "No se permite fumar", "No se permiten fiestas", "No se permiten visitas", "Check-in después de las 3 PM", "Check-out antes de las 11 AM", "Silencio después de las 10 PM"].sample(3)
  )
end

# Create 2000 Airbnb
2000.times do
  precio_noche = Faker::Number.between(from: 5, to: 150) * 1000
  piezas = Faker::Number.between(from: 1, to: 6)
  camas = Faker::Number.between(from: 1, to: 6)
  banos = Faker::Number.between(from: 1, to: 4)

  if precio_noche > 100000
    piezas = Faker::Number.between(from: 4, to: 6)
    camas = Faker::Number.between(from: 4, to: 6)
    banos = Faker::Number.between(from: 3, to: 4)
  elsif precio_noche > 75000
    piezas = Faker::Number.between(from: 3, to: 5)
    camas = Faker::Number.between(from: 3, to: 5)
    banos = Faker::Number.between(from: 2, to: 3)
  elsif precio_noche > 50000
    piezas = Faker::Number.between(from: 2, to: 4)
    camas = Faker::Number.between(from: 2, to: 4)
    banos = Faker::Number.between(from: 2, to: 3)
  elsif precio_noche > 25000
    piezas = Faker::Number.between(from: 2, to: 3)
    camas = Faker::Number.between(from: 2, to: 3)
    banos = Faker::Number.between(from: 1, to: 2)
  end

  comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación", "Jacuzzi", "Balcón", "Vista al mar", "Chimenea"].sample(5)
  descripcion = ["Disfruta de una estadía en el corazón de la ciudad", "Relájate en un lugar tranquilo y acogedor", "Descubre la historia de la ciudad desde tu ventana", "Aventúrate en la naturaleza y descansa en un lugar cómodo", "Experimenta el lujo y la comodidad en este alojamiento", "Perfecto para familias y grupos grandes", "Ideal para una escapada romántica", "Ubicación céntrica con fácil acceso a atracciones turísticas"].sample

  ciudad = Faker::Address.city
  Airbnb.create(
    reserva_id: reservas.sample.id,
    nombre_hospedaje: ["Casa", "Departamento", "Loft", "Cabaña", "Villa", "Estudio", "Habitación", "Hostal", "Residencia", "Suite"].sample + " en " + ciudad,
    ubicacion: ciudad,
    precio_noche: precio_noche,
    estrellas: Faker::Number.between(from: 1, to: 5),
    comodidades: comodidades,
    disponibilidad: [true, false].sample,
    nombre_anfitrion: Faker::Name.name,
    contacto_anfitrion: Faker::Base.regexify(/\+56 (9|2) \d{4} \d{4}/),
    descripcion: descripcion,
    piezas: piezas,
    camas: camas,
    banos: banos
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

