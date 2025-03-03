require 'faker'

Faker::Config.locale = 'es'

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

resenas = {
  1 => ["Malo", "Pésimo", "No vuelvo más", "Muy insatisfecho", "Completamente decepcionado"],
  2 => ["Regular", "No lo recomendaría", "Hubo varios problemas", "No me convenció del todo"],
  3 => ["Aceptable", "Servicio regular", "Cumplió con mis expectativas, pero sin destacar", "Podría mejorar"],
  4 => ["Bueno", "Me atendieron bien", "Satisfecho, pero hay detalles por mejorar", "Buena experiencia en general"],
  5 => ["Excelente", "Superó mis expectativas", "Muy satisfecho", "Sin duda volveré", "Servicio de primera"]
}


# Erase all data
Habitaciones.destroy_all
# Airbnb.destroy_all
# Hoteles.destroy_all
Seguro.destroy_all
Review.destroy_all
# Trenes.destroy_all
# Aviones.destroy_all
# Buses.destroy_all
# Hospedaje.destroy_all
# Participante.destroy_all
# Panorama.destroy_all
Reserva.destroy_all
Agenda.destroy_all
Usuario.destroy_all
Empleado.destroy_all


def calculateDV(run)
  rut = run.to_s
  suma = 0
  multiplo = 2
  (rut.length - 1).downto(0) do |i|
    suma += rut[i].to_i * multiplo
    multiplo = multiplo == 7 ? 2 : multiplo + 1
  end
  dv = 11 - (suma % 11)
  dv == 11 ? '0' : dv == 10 ? 'K' : dv.to_s
end

def createUsername(nombre)
  opcion = rand(1..3)
  if opcion == 1
    return nombre.split.map { |word| word[0, 2].downcase }.join
  elsif opcion == 2
    return nombre.split[0].downcase + rand(100..9999).to_s
  else
    return nombre.split[0] + nombre.split[-1].downcase
  end
end

def createUsuario()
  nombre = Faker::Name.name
  run = Faker::Number.unique.between(from: 200000, to: 30000000)
  dominiosUsuarios = ['tourket.com', 'wass.com', 'marmol.com', 'outluc.com', 'edubus.cal', 'viajesanma.com']
  Usuario.create!(
    nombre: nombre,
    run: run,
    dv: calculateDV(run),
    correo: createUsername(nombre) + '@' + dominiosUsuarios.sample,
    contrasena: Faker::Internet.password,
    username: createUsername(nombre),
    telefono_contacto: Faker::Base.unique.regexify(/\+56 (9|2) \d{4} \d{4}/),
    puntos: rand(100..10000)
  )
end

def createEmpleado()
  nombre = Faker::Name.name
  run = Faker::Number.unique.between(from: 200000, to: 30000000)
  Empleado.create!(
    nombre: nombre,
    run: run,
    dv: calculateDV(run),
    correo: createUsername(nombre) + '@viajes.cl',
    contrasena: Faker::Internet.password,
    username: createUsername(nombre),
    telefono_contacto: Faker::Base.unique.regexify(/\+56 (9|2) \d{4} \d{4}/),
    jornada: ["Diurno", "Nocturno"].sample,
    contrato: ["Part time", "Full time"].sample,
    isapre: ["Más vida", "Colmena", "Consalud", "Banmédica", "Fonasa"].sample
  )
end

def createBuses(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..50) * 1000
  tipo = "Normal"

  if tiempo_estimado > 600
    precio_asiento = rand(50..200) * 1000
    tipo = "Cama"
  elsif tiempo_estimado > 480
    precio_asiento = rand(40..150) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 360
    precio_asiento = rand(30..100) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 240
    precio_asiento = rand(20..80) * 1000
    tipo = ["Normal", "Semi-cama"].sample
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

  fecha_llegada = (fecha_salida + tiempo_estimado.minutes).to_date
  ciudad_llegada = Faker::Address.city
  Reserva.create(
    empleado_id: Empleado.all.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: ciudad_origen,
    lugar_llegada: ciudad_llegada,
    capacidad: rand(30..50),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_buses.sample,
    fecha_salida: fecha_salida,
    fecha_llegada: fecha_llegada,
    tipo: tipo,
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3),
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_salida - 1),
    monto: precio_asiento * cantidad_personas,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: 'No disponible'
  )
  return fecha_llegada, ciudad_llegada
end

def createAviones(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..200) * 1000
  clase = ["Clase ejecutiva", "Clase económica"].sample
  escalas =  []

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

  if tiempo_estimado > 3600
    precio_asiento = rand(150..500) * 1000
    clase = "Primera clase"
    escalas = Array.new(rand(2..5)) { Faker::Address.city }
  elsif tiempo_estimado > 2880
    precio_asiento = rand(100..400) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
    escalas = Array.new(rand(1..4)) { Faker::Address.city }
  elsif tiempo_estimado > 2160
    precio_asiento = rand(80..300) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
    escalas = Array.new(rand(0..3)) { Faker::Address.city }
  elsif tiempo_estimado > 1440
    precio_asiento = rand(50..200) * 1000
    clase = ["Clase ejecutiva", "Clase económica"].sample
    escalas = Array.new(rand(0..2)) { Faker::Address.city }
  elsif tiempo_estimado > 720
    precio_asiento = rand(30..150) * 1000
    clase = "Clase económica"
    escalas = Array.new(rand(0..1)) { Faker::Address.city }
  end

  fecha_llegada = (fecha_salida + tiempo_estimado.minutes).to_date
  ciudad_llegada = Faker::Address.city
  Reserva.create(
    empleado_id: Empleado.all.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: ciudad_origen,
    lugar_llegada: ciudad_llegada,
    capacidad: rand(1..100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_aerolineas.sample,
    fecha_salida: fecha_salida,
    fecha_llegada: fecha_llegada,
    clase: clase,
    escalas: escalas,
    # Parámetros de reserva
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_salida - 1),
    monto: precio_asiento * cantidad_personas,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: 'No disponible'
  )
  return fecha_llegada, ciudad_llegada
end

def createTrenes(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..200) * 1000
  comodidades = []

  if tiempo_estimado > 3600
    precio_asiento = rand(150..500) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(7)
  elsif tiempo_estimado > 2880
    precio_asiento = rand(100..400) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(6)
  elsif tiempo_estimado > 2160
    precio_asiento = rand(80..300) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(5)
  elsif tiempo_estimado > 1440
    precio_asiento = rand(50..200) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(4)
  elsif tiempo_estimado > 720
    precio_asiento = rand(30..150) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  end

  empresas_trenes = [
  "Amtrak", "Eurostar", "Thalys", "TGV (SNCF)", "Renfe", "AVE", 
  "Deutsche Bahn (DB)", "Trenitalia", "Italo", "ÖBB (Austria)", 
  "SBB (Suiza)", "Nederlandse Sp", "NS International", "SJ (Suecia)",
  "VR (Finlandia)", "RZD (Rusia)", "SNCB (Bélgica)", "CP (Portugal)",
  "NSB (Noruega)", "DSB (Dinamarca)", "VRZ (Croacia)", "ZSSK (Eslovaquia)",
  "CD (República Checa)", "PKP (Polonia)", "MÁV (Hungría)", "CFR (Rumania)",
  "BDZ (Bulgaria)", "ZS (Eslovenia)", "HŽ (Croacia)", "ŽSSK (Eslovaquia)",
  "ZFBH (Bosnia y Herzegovina)", "ŽFBH (Bosnia y Herzegovina)", "ŽFBH (Bosnia y Herzegovina)"
  ]

  fecha_llegada = (fecha_salida + tiempo_estimado.minutes).to_date
  ciudad_llegada = Faker::Address.city
  Reserva.create(
    empleado_id: Empleado.all.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: ciudad_origen,
    lugar_llegada: ciudad_llegada,
    capacidad: rand(1..100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_trenes.sample,
    fecha_salida: fecha_salida,
    fecha_llegada: fecha_llegada,
    paradas: Array.new(rand(0..5)) { Faker::Address.city },
    comodidades: comodidades,
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_salida - 1),
    monto: precio_asiento * cantidad_personas,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: 'No disponible'
  )
  return fecha_llegada, ciudad_llegada
end

def createPanorama(fecha_panorama, ubicacion, agenda_id, cantidad_personas)
  precio_persona = rand(5..100) * 1000
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
  duracion = rand(1..7)

  Reserva.create(
    empresa: empresas_turismo.sample,
    nombre_panorama: ["Tour", "Paseo", "Excursión", "Visita", "Aventura"].sample,
    descripcion: ["Disfruta de un día en la naturaleza", "Conoce la historia de la ciudad", "Aventúrate en la montaña", "Descubre la gastronomía local", "Relájate en la playa"].sample,
    ubicacion: ubicacion,
    duracion: duracion,
    precio_persona: precio_persona,
    capacidad: rand(1..50),
    restricciones: ["No apto para menores de 18 años", "No apto para personas con movilidad reducida", "No apto para personas con problemas de salud", "No apto para personas con problemas de movilidad"].sample,
    fecha_panorama: fecha_panorama,
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_panorama - 1),
    monto: precio_persona * cantidad_personas,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: 'No disponible'
  )
end

def planingPanorama(fecha_checkin, ubicacion, agenda_id, cantidad_personas, dias)
  fecha_panorama = fecha_checkin
  panoramas = dias - 1
  panoramas.times do
    fecha_panorama += 1.day
    createPanorama(fecha_panorama, ubicacion, agenda_id, cantidad_personas)
  end
end

def createHoteles(fecha_checkin, ubicacion, agenda_id, cantidad_personas)
  dias = rand(1..7)
  fecha_checkout = fecha_checkin + dias.days
  precio_noche = rand(5..150) * 1000

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

  Reserva.create(
    nombre_hospedaje: empresas_hoteleras.sample,
    ubicacion: ubicacion,
    precio_noche: precio_noche,
    estrellas: rand(1..5),
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación"].sample(5),
    disponibilidad: [true, false].sample,
    fecha_checkin: fecha_checkin,
    fecha_checkout: fecha_checkout,
    politicas: ["No se permiten mascotas", "No se permite fumar", "No se permiten fiestas", "No se permiten visitas", "Check-in después de las 3 PM", "Check-out antes de las 11 AM", "Silencio después de las 10 PM"].sample(3),
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_checkin - 1),
    monto: precio_noche * cantidad_personas * dias,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: ['Disponible', 'No disponible'].sample  
  )
  planingPanorama(fecha_checkin, ubicacion, agenda_id, cantidad_personas, dias)
  return fecha_checkout
end

def createAirbnb(fecha_checkin, ubicacion, agenda_id, cantidad_personas)
  dias = rand(1..7)
  fecha_checkout = fecha_checkin + dias.days
  precio_noche = rand(5..150) * 1000
  piezas = rand(1..6)
  camas = rand(1..6)
  banos = rand(1..4)

  if precio_noche > 100000
    piezas = rand(4..6)
    camas = rand(4..6)
    banos = rand(3..4)
  elsif precio_noche > 75000
    piezas = rand(3..5)
    camas = rand(3..5)
    banos = rand(2..3)
  elsif precio_noche > 50000
    piezas = rand(2..4)
    camas = rand(2..4)
    banos = rand(2..3)
  elsif precio_noche > 25000
    piezas = rand(2..3)
    camas = rand(2..3)
    banos = rand(1..2)
  end

  comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación", "Jacuzzi", "Balcón", "Vista al mar", "Chimenea"].sample(5)
  descripcion = ["Disfruta de una estadía en el corazón de la ciudad", "Relájate en un lugar tranquilo y acogedor", "Descubre la historia de la ciudad desde tu ventana", "Aventúrate en la naturaleza y descansa en un lugar cómodo", "Experimenta el lujo y la comodidad en este alojamiento", "Perfecto para familias y grupos grandes", "Ideal para una escapada romántica", "Ubicación céntrica con fácil acceso a atracciones turísticas"].sample
  Reserva.create(
    nombre_hospedaje: ["Casa", "Departamento", "Loft", "Cabaña", "Villa", "Estudio", "Habitación", "Hostal", "Residencia", "Suite"].sample + " en " + ubicacion,
    ubicacion: ubicacion,
    precio_noche: precio_noche,
    estrellas: rand(1..5),
    comodidades: comodidades,
    disponibilidad: false,
    nombre_anfitrion: Faker::Name.name,
    contacto_anfitrion: Faker::Base.regexify(/\+56 (9|2) \d{4} \d{4}/),
    descripcion: descripcion,
    fecha_checkin: fecha_checkin,
    fecha_checkout: fecha_checkout,
    piezas: piezas,
    camas: camas,
    banos: banos,
    agenda_id: agenda_id,
    fecha: Faker::Date.between(from: '2025-01-01', to: fecha_checkin - 1),
    monto: precio_noche * dias,
    cantidad_personas: cantidad_personas,
    estado_disponibilidad: ['Disponible', 'No disponible'].sample  
  )
  planingPanorama(fecha_checkin, ubicacion, agenda_id, cantidad_personas, dias)
  return fecha_checkout
end

# Creación Usuarios
973.times do
  createUsuario()
end

# Creación Empleados
284.times do
  createEmpleado()
end

# empleados = Empleado.all
usuarios = Usuario.all

# Creación agendas
1512.times do
  Agenda.create!(
    etiqueta: ["Vacaciones", "Cena de Trabajo", "Salida con Familia", "Salida con Amigos", "Aniversario"].sample,
    usuario_id: usuarios.sample.id
  )
end

agendas = Agenda.all

# Creación Reservas
1512.times do
  fecha_salida = Faker::Date.between(from: '2025-01-01', to: '2026-11-30')
  ciudad_origen = Faker::Address.city
  agenda_id = agendas.sample.id
  prob_viaje = rand
  cantidad_personas = rand(1..10)
  rand(1..3).times do
    if prob_viaje < 0.25
      fecha_salida, ciudad_origen = createAviones(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
    elsif prob_viaje < 0.60
      fecha_salida, ciudad_origen = createTrenes(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
    else
      fecha_salida, ciudad_origen = createBuses(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
    end
    if rand < 0.5
      if rand < 0.5
        fecha_salida = createAirbnb(fecha_salida, ciudad_origen, agenda_id, cantidad_personas) 
      else
        fecha_salida = createHoteles(fecha_salida, ciudad_origen, agenda_id, cantidad_personas)
      end
    end
  end
end

empleados = Empleado.all
empresas_buses = [
  "Turbus", "Pullman Bus", "Condor Bus", "EME Bus", "JetSur",
  "Buses Romani", "Buses Nilahue", "Buses Ahumada", "Buses Bio Bio",
  "Flecha Bus", "Chevallier", "Andesmar", "Via Bariloche", "El Rápido Internacional",
  "Plusmar", "Crucero del Norte", "ADO", "Estrella Roja", "Primera Plus",
  "ETN Turistar", "Omnibus de México", "Futura", "Alsa", "Avanza",
  "Socibus", "Monbus", "Damas", "Greyhound", "Megabus",
  "FlixBus", "BoltBus"
]
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
empresas_trenes = [
  "Amtrak", "Eurostar", "Thalys", "TGV (SNCF)", "Renfe", "AVE", 
  "Deutsche Bahn (DB)", "Trenitalia", "Italo", "ÖBB (Austria)", 
  "SBB (Suiza)", "Nederlandse Sp", "NS International", "SJ (Suecia)",
  "VR (Finlandia)", "RZD (Rusia)", "SNCB (Bélgica)", "CP (Portugal)",
  "NSB (Noruega)", "DSB (Dinamarca)", "VRZ (Croacia)", "ZSSK (Eslovaquia)",
  "CD (República Checa)", "PKP (Polonia)", "MÁV (Hungría)", "CFR (Rumania)",
  "BDZ (Bulgaria)", "ZS (Eslovenia)", "HŽ (Croacia)", "ŽSSK (Eslovaquia)",
  "ZFBH (Bosnia y Herzegovina)", "ŽFBH (Bosnia y Herzegovina)", "ŽFBH (Bosnia y Herzegovina)"
]
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

comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación", "Jacuzzi", "Balcón", "Vista al mar", "Chimenea"].sample(5)
descripcion = ["Disfruta de una estadía en el corazón de la ciudad", "Relájate en un lugar tranquilo y acogedor", "Descubre la historia de la ciudad desde tu ventana", "Aventúrate en la naturaleza y descansa en un lugar cómodo", "Experimenta el lujo y la comodidad en este alojamiento", "Perfecto para familias y grupos grandes", "Ideal para una escapada romántica", "Ubicación céntrica con fácil acceso a atracciones turísticas"].sample


321.times do
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..50) * 1000
  tipo = "Normal"

  if tiempo_estimado > 600
    precio_asiento = rand(50..200) * 1000
    tipo = "Cama"
  elsif tiempo_estimado > 480
    precio_asiento = rand(40..150) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 360
    precio_asiento = rand(30..100) * 1000
    tipo = ["Semi-cama", "Cama"].sample
  elsif tiempo_estimado > 240
    precio_asiento = rand(20..80) * 1000
    tipo = ["Normal", "Semi-cama"].sample
  end
  Reserva.create(
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: rand(30..50),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_buses.sample,
    fecha_salida: Faker::Date.between(from: '2025-01-01', to: '2026-11-30'),
    tipo: tipo,
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3),
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible'
  )
end
# Creación Aviones
240.times do
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..200) * 1000
  clase = ["Clase ejecutiva", "Clase económica"].sample

  if tiempo_estimado > 3600
    precio_asiento = rand(150..500) * 1000
    clase = "Primera clase"
  elsif tiempo_estimado > 2880
    precio_asiento = rand(100..400) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
  elsif tiempo_estimado > 2160
    precio_asiento = rand(80..300) * 1000
    clase = ["Primera clase", "Clase ejecutiva"].sample
  elsif tiempo_estimado > 1440
    precio_asiento = rand(50..200) * 1000
    clase = ["Clase ejecutiva", "Clase económica"].sample
  elsif tiempo_estimado > 720
    precio_asiento = rand(30..150) * 1000
    clase = "Clase económica"
  end

  fecha_salida = Faker::Date.between(from: '2025-01-01', to: '2026-11-30')
  fecha_llegada = (fecha_salida + tiempo_estimado.hours).to_date
   
  Reserva.create(
    empleado_id: empleados.sample.id,
    numero_viaje: Faker::Number.unique.between(from: 1, to: 100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: rand(1..100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_aerolineas.sample,
    fecha_salida: fecha_salida,
    fecha_llegada: fecha_llegada,
    clase: clase,
    escalas: Array.new(rand(0..5)) { Faker::Address.city },
    # Parámetros de reserva
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible'
  )
end

# Creación Trenes
293.times do
  tiempo_estimado = rand(120..4320)
  precio_asiento = rand(5..200) * 1000

  if tiempo_estimado > 3600
    precio_asiento = rand(150..500) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(7)
  elsif tiempo_estimado > 2880
    precio_asiento = rand(100..400) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(6)
  elsif tiempo_estimado > 2160
    precio_asiento = rand(80..300) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(5)
  elsif tiempo_estimado > 1440
    precio_asiento = rand(50..200) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(4)
  elsif tiempo_estimado > 720
    precio_asiento = rand(30..150) * 1000
    comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables"].sample(3)
  end

  fecha_salida = Faker::Date.between(from: '2025-01-01', to: '2026-11-30')
  fecha_llegada = (fecha_salida + tiempo_estimado.hours).to_date
  Reserva.create(
    empleado_id: empleados.sample.id,
    numero_viaje: rand(1..100000),
    lugar_origen: Faker::Address.city,
    lugar_llegada: Faker::Address.city,
    capacidad: rand(1..100),
    tiempo_estimado: tiempo_estimado,
    precio_asiento: precio_asiento,
    empresa: empresas_trenes.sample,
    fecha_salida: fecha_salida,
    fecha_llegada: fecha_llegada,
    paradas: Array.new(rand(0..5)) { Faker::Address.city },
    comodidades: comodidades,
    # Parámetros de reserva
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible',
  )
end

# Create Panoramas
1492.times do
  fecha_panorama = Faker::Date.between(from: '2025-01-01', to: '2026-12-31')
  precio_persona = rand(5..100) * 1000
  Reserva.create(
    empresa: empresas_turismo.sample,
    nombre_panorama: ["Tour", "Paseo", "Excursión", "Visita", "Aventura"].sample,
    descripcion: ["Disfruta de un día en la naturaleza", "Conoce la historia de la ciudad", "Aventúrate en la montaña", "Descubre la gastronomía local", "Relájate en la playa"].sample,
    ubicacion: Faker::Address.city,
    duracion: rand(1..7),
    precio_persona: precio_persona,
    capacidad: rand(1..50),
    restricciones: ["No apto para menores de 18 años", "No apto para personas con movilidad reducida", "No apto para personas con problemas de salud", "No apto para personas con problemas de movilidad"].sample,
    fecha_panorama: fecha_panorama,
    # Parámetros de reserva
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible'
  )
end

panoramas = Reserva.where.not(nombre_panorama: nil)
230.times do
  Participante.create(
    panorama_id: panoramas.sample.id,
    nombre_participante: usuarios.sample.nombre,
  )
end



# Create 2000 Hospedajes
241.times do
  fecha_checkin = Faker::Date.between(from: '2025-01-01', to: '2026-11-30')
  fecha_checkout = Faker::Date.between(from: fecha_checkin, to: '2026-12-31')
  precio_noche = rand(5..150) * 1000
  Reserva.create(
    nombre_hospedaje: empresas_hoteleras.sample,
    ubicacion: Faker::Address.city,
    precio_noche: precio_noche,
    estrellas: rand(1..5),
    comodidades: ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación"].sample(5),
    disponibilidad: true,
    fecha_checkin: fecha_checkin,
    fecha_checkout: fecha_checkout,
    politicas: ["No se permiten mascotas", "No se permite fumar", "No se permiten fiestas", "No se permiten visitas", "Check-in después de las 3 PM", "Check-out antes de las 11 AM", "Silencio después de las 10 PM"].sample(3),
    # Parámetros de reserva
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible',
  )
end


# Create 2000 Airbnb
274.times do
  precio_noche = rand(5..150) * 1000
  piezas = rand(1..6)
  camas = rand(1..6)
  banos = rand(1..4)

  if precio_noche > 100000
    piezas = rand(4..6)
    camas = rand(4..6)
    banos = rand(3..4)
  elsif precio_noche > 75000
    piezas = rand(3..5)
    camas = rand(3..5)
    banos = rand(2..3)
  elsif precio_noche > 50000
    piezas = rand(2..4)
    camas = rand(2..4)
    banos = rand(2..3)
  elsif precio_noche > 25000
    piezas = rand(2..3)
    camas = rand(2..3)
    banos = rand(1..2)
  end
  comodidades = ["Wifi", "TV", "Aire acondicionado", "Calefacción", "Baño", "Comida", "Agua", "Asientos reclinables", "Piscina", "Gimnasio", "Spa", "Servicio a la habitación", "Jacuzzi", "Balcón", "Vista al mar", "Chimenea"].sample(5)
  descripcion = ["Disfruta de una estadía en el corazón de la ciudad", "Relájate en un lugar tranquilo y acogedor", "Descubre la historia de la ciudad desde tu ventana", "Aventúrate en la naturaleza y descansa en un lugar cómodo", "Experimenta el lujo y la comodidad en este alojamiento", "Perfecto para familias y grupos grandes", "Ideal para una escapada romántica", "Ubicación céntrica con fácil acceso a atracciones turísticas"].sample

  ciudad = Faker::Address.city

  fecha_checkin = Faker::Date.between(from: '2025-01-01', to: '2026-11-30')
  fecha_checkout = Faker::Date.between(from: fecha_checkin, to: '2026-12-31')
  Reserva.create(
    nombre_hospedaje: ["Casa", "Departamento", "Loft", "Cabaña", "Villa", "Estudio", "Habitación", "Hostal", "Residencia", "Suite"].sample + " en " + ciudad,
    ubicacion: ciudad,
    precio_noche: precio_noche,
    estrellas: rand(1..5),
    comodidades: comodidades,
    disponibilidad: true,
    nombre_anfitrion: Faker::Name.name,
    contacto_anfitrion: Faker::Base.regexify(/\+56 (9|2) \d{4} \d{4}/),
    descripcion: descripcion,
    fecha_checkin: fecha_checkin,
    fecha_checkout: fecha_checkout,
    piezas: piezas,
    camas: camas,
    banos: banos,
    # Parámetros de reserva
    agenda_id: nil,
    fecha: nil,
    monto: nil,
    cantidad_personas: nil,
    estado_disponibilidad: 'Disponible' 
  )
end

hoteles = Reserva.where.not(politicas: nil);

# Create 40000 habitaciones
320.times do
  Habitaciones.create(
    hotel_id: hoteles.sample.id,
    numero_habitacion: Faker::Number.unique.between(from: 1, to: 50000),
    tipo: ["Sencilla", "Doble", "Matrimonial", "Triple", "Cuadruple", "Suite"].sample
  )
end


reservas = Reserva.all

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
220.times do
  tipo_seguro = seguros_viaje.keys.sample
  clausulas_seguro = seguros_viaje[tipo_seguro]
  Seguro.create(
    reserva_id: reservas.sample.id,
    usuario_id: usuarios.sample.id,
    empresa: empresas_seguros.sample,
    valor: rand(5..100) * 1000,
    clausula: clausulas_seguro.sample(2).join(", "),
    tipo: tipo_seguro
  )
end

# Create 100 reviews
220.times do
  estrellas = rand(1..5)
  comentario = resenas[estrellas]
  Review.create(
    reserva_id: reservas.sample.id,
    usuario_id: usuarios.sample.id,
    estrellas: estrellas,
    descripcion: comentario.sample
  )
end

puts "Se crearon exitosamente 🎉🎉✨✨🎉🎉"