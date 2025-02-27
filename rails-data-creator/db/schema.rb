# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_18_204008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "agendas", force: :cascade do |t|
    t.text "etiqueta"
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_agendas_on_usuario_id"
  end

  create_table "airbnbs", force: :cascade do |t|
    t.string "nombre_hospedaje"
    t.string "ubicacion"
    t.float "precio_noche"
    t.float "estrellas"
    t.text "comodidades", default: [], array: true
    t.boolean "disponibilidad"
    t.string "nombre_anfitrion"
    t.string "contacto_anfitrion"
    t.text "descripcion"
    t.date "fecha_checkin"
    t.date "fecha_checkout"
    t.integer "piezas"
    t.integer "camas"
    t.integer "banos"
    t.bigint "hospedajes_id"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospedajes_id"], name: "index_airbnbs_on_hospedajes_id"
    t.index ["reservas_id"], name: "index_airbnbs_on_reservas_id"
  end

  create_table "aviones", force: :cascade do |t|
    t.bigint "empleado_id", null: false
    t.integer "numero_viaje"
    t.string "lugar_origen"
    t.string "lugar_llegada"
    t.integer "capacidad"
    t.integer "tiempo_estimado"
    t.float "precio_asiento"
    t.string "empresa"
    t.date "fecha_salida"
    t.date "fecha_llegada"
    t.string "clase"
    t.string "escalas", default: [], array: true
    t.bigint "transportes_id"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empleado_id"], name: "index_aviones_on_empleado_id"
    t.index ["reservas_id"], name: "index_aviones_on_reservas_id"
    t.index ["transportes_id"], name: "index_aviones_on_transportes_id"
  end

  create_table "buses", force: :cascade do |t|
    t.bigint "empleado_id", null: false
    t.integer "numero_viaje"
    t.string "lugar_origen"
    t.string "lugar_llegada"
    t.integer "capacidad"
    t.integer "tiempo_estimado"
    t.float "precio_asiento"
    t.string "empresa"
    t.date "fecha_salida"
    t.date "fecha_llegada"
    t.string "tipo"
    t.text "comodidades", default: [], array: true
    t.bigint "transportes_id"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empleado_id"], name: "index_buses_on_empleado_id"
    t.index ["reservas_id"], name: "index_buses_on_reservas_id"
    t.index ["transportes_id"], name: "index_buses_on_transportes_id"
  end

  create_table "empleados", force: :cascade do |t|
    t.string "nombre"
    t.integer "run"
    t.integer "dv"
    t.string "correo"
    t.string "contrasena"
    t.string "username"
    t.string "telefono_contacto"
    t.string "jornada"
    t.string "isapre"
    t.string "contrato"
    t.bigint "personas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personas_id"], name: "index_empleados_on_personas_id"
  end

  create_table "habitaciones", force: :cascade do |t|
    t.integer "numero_habitacion"
    t.string "tipo", default: "Sencilla", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_habitaciones_on_hotel_id"
  end

  create_table "hospedajes", force: :cascade do |t|
    t.string "nombre_hospedaje"
    t.string "ubicacion"
    t.float "precio_noche"
    t.float "estrellas"
    t.text "comodidades"
    t.boolean "disponibilidad"
    t.date "fecha_checkin"
    t.date "fecha_checkout"
    t.string "politicas", default: [], array: true
    t.string "nombre_anfitrion"
    t.string "contacto_anfitrion"
    t.text "descripcion"
    t.integer "piezas"
    t.integer "camas"
    t.integer "banos"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservas_id"], name: "index_hospedajes_on_reservas_id"
  end

  create_table "hoteles", force: :cascade do |t|
    t.string "nombre_hospedaje"
    t.string "ubicacion"
    t.float "precio_noche"
    t.float "estrellas"
    t.text "comodidades", default: [], array: true
    t.boolean "disponibilidad"
    t.date "fecha_checkin"
    t.date "fecha_checkout"
    t.string "politicas", default: [], array: true
    t.bigint "hospedajes_id"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospedajes_id"], name: "index_hoteles_on_hospedajes_id"
    t.index ["reservas_id"], name: "index_hoteles_on_reservas_id"
  end

  create_table "panoramas", force: :cascade do |t|
    t.string "empresa"
    t.string "nombre_panorama"
    t.text "descripcion"
    t.string "ubicacion"
    t.integer "duracion"
    t.float "precio_persona"
    t.integer "capacidad"
    t.text "restricciones", default: [], array: true
    t.date "fecha_panorama"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservas_id"], name: "index_panoramas_on_reservas_id"
  end

  create_table "participantes", force: :cascade do |t|
    t.bigint "panorama_id", null: false
    t.string "nombre_participante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["panorama_id"], name: "index_participantes_on_panorama_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre"
    t.integer "run"
    t.integer "dv"
    t.string "correo"
    t.string "contrasena"
    t.string "username"
    t.string "telefono_contacto"
    t.integer "puntos"
    t.string "jornada"
    t.string "isapre"
    t.string "contrato"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservas", force: :cascade do |t|
    t.bigint "agenda_id"
    t.date "fecha"
    t.float "monto"
    t.integer "cantidad_personas"
    t.string "estado_disponibilidad", default: "Disponible"
    t.bigint "empleado_id"
    t.integer "numero_viaje"
    t.string "lugar_origen"
    t.string "lugar_llegada"
    t.integer "capacidad"
    t.integer "tiempo_estimado"
    t.float "precio_asiento"
    t.string "empresa"
    t.date "fecha_salida"
    t.date "fecha_llegada"
    t.string "tipo"
    t.text "comodidades", default: [], array: true
    t.string "escalas", default: [], array: true
    t.string "clase"
    t.string "paradas", default: [], array: true
    t.string "nombre_hospedaje"
    t.string "ubicacion"
    t.float "precio_noche"
    t.float "estrellas"
    t.boolean "disponibilidad"
    t.date "fecha_checkin"
    t.date "fecha_checkout"
    t.string "politicas", default: [], array: true
    t.string "nombre_anfitrion"
    t.string "contacto_anfitrion"
    t.text "descripcion"
    t.integer "piezas"
    t.integer "camas"
    t.integer "banos"
    t.string "nombre_panorama"
    t.integer "duracion"
    t.float "precio_persona"
    t.text "restricciones", default: [], array: true
    t.date "fecha_panorama"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_reservas_on_agenda_id"
    t.index ["empleado_id"], name: "index_reservas_on_empleado_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "estrellas"
    t.text "descripcion"
    t.bigint "usuario_id", null: false
    t.bigint "reserva_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserva_id"], name: "index_reviews_on_reserva_id"
    t.index ["usuario_id"], name: "index_reviews_on_usuario_id"
  end

  create_table "seguros", force: :cascade do |t|
    t.string "tipo"
    t.float "valor"
    t.text "clausula"
    t.string "empresa"
    t.bigint "usuario_id", null: false
    t.bigint "reserva_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserva_id"], name: "index_seguros_on_reserva_id"
    t.index ["usuario_id"], name: "index_seguros_on_usuario_id"
  end

  create_table "transportes", force: :cascade do |t|
    t.bigint "empleado_id", null: false
    t.integer "numero_viaje"
    t.string "lugar_origen"
    t.string "lugar_llegada"
    t.integer "capacidad"
    t.integer "tiempo_estimado"
    t.float "precio_asiento"
    t.string "empresa"
    t.date "fecha_salida"
    t.date "fecha_llegada"
    t.string "tipo"
    t.text "comodidades", default: [], array: true
    t.string "escalas", default: [], array: true
    t.string "clase"
    t.string "paradas", default: [], array: true
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empleado_id"], name: "index_transportes_on_empleado_id"
    t.index ["reservas_id"], name: "index_transportes_on_reservas_id"
  end

  create_table "trenes", force: :cascade do |t|
    t.bigint "empleado_id", null: false
    t.integer "numero_viaje"
    t.string "lugar_origen"
    t.string "lugar_llegada"
    t.integer "capacidad"
    t.integer "tiempo_estimado"
    t.float "precio_asiento"
    t.string "empresa"
    t.date "fecha_salida"
    t.date "fecha_llegada"
    t.string "paradas", default: [], array: true
    t.text "comodidades", default: [], array: true
    t.bigint "transportes_id"
    t.bigint "reservas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empleado_id"], name: "index_trenes_on_empleado_id"
    t.index ["reservas_id"], name: "index_trenes_on_reservas_id"
    t.index ["transportes_id"], name: "index_trenes_on_transportes_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.integer "run"
    t.integer "dv"
    t.string "correo"
    t.string "contrasena"
    t.string "username"
    t.string "telefono_contacto"
    t.integer "puntos"
    t.bigint "personas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personas_id"], name: "index_usuarios_on_personas_id"
  end

  add_foreign_key "agendas", "usuarios"
  add_foreign_key "airbnbs", "hospedajes", column: "hospedajes_id"
  add_foreign_key "airbnbs", "reservas", column: "reservas_id"
  add_foreign_key "aviones", "empleados"
  add_foreign_key "aviones", "reservas", column: "reservas_id"
  add_foreign_key "aviones", "transportes", column: "transportes_id"
  add_foreign_key "buses", "empleados"
  add_foreign_key "buses", "reservas", column: "reservas_id"
  add_foreign_key "buses", "transportes", column: "transportes_id"
  add_foreign_key "empleados", "personas", column: "personas_id"
  add_foreign_key "habitaciones", "hoteles", column: "hotel_id"
  add_foreign_key "hospedajes", "reservas", column: "reservas_id"
  add_foreign_key "hoteles", "hospedajes", column: "hospedajes_id"
  add_foreign_key "hoteles", "reservas", column: "reservas_id"
  add_foreign_key "panoramas", "reservas", column: "reservas_id"
  add_foreign_key "participantes", "panoramas"
  add_foreign_key "reservas", "agendas"
  add_foreign_key "reservas", "empleados"
  add_foreign_key "reviews", "reservas"
  add_foreign_key "reviews", "usuarios"
  add_foreign_key "seguros", "reservas"
  add_foreign_key "seguros", "usuarios"
  add_foreign_key "transportes", "empleados"
  add_foreign_key "transportes", "reservas", column: "reservas_id"
  add_foreign_key "trenes", "empleados"
  add_foreign_key "trenes", "reservas", column: "reservas_id"
  add_foreign_key "trenes", "transportes", column: "transportes_id"
  add_foreign_key "usuarios", "personas", column: "personas_id"
end
