# Esquema Relacional del Sistema de Reservas de Viajes

## Entidades y Atributos

### 1. **Usuario**
- id (PK): integer
- correo (único): string
- nombre: string
- run (unico): integer
- dv: integer
- contraseña: string
- telefono_contacto: string
- puntos: integer
- fecha_registro: date

### 2. **Empleado**
- id (PK): integer
- correo (único): string
- nombre: string
- run (unico): string
- dv: string
- contraseña: string
- telefono_contacto: string
- jornada: string
- contrato: string
- isapre: string
- cargo: string

### 3. **Agenda**
- id (PK): integer
- etiqueta: string
- usuario_id (FK → Usuario.id): integer
- fecha_creacion: date

### 4. **Reserva**
- id (PK): integer
- agenda_id (FK → Agenda.id): integer
- fecha: date
- monto: float
- cantidad_personas: integer
- estado: string

### 5. **Seguro**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- usuario_id (FK → Usuario.id): integer
- empresa: string
- valor: float
- clausula: string
- tipo: string

### 6. **Review**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- usuario_id (FK → Usuario.id): integer
- estrellas: float
- descripcion: string
- fecha_publicacion: date

### 7. **Buses**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- tipo: string
- comodidades: string[]
- disponibilidad: boolean

### 8. **Aviones**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- clase: string
- escalas: string[]
- disponibilidad: boolean

### 9. **Trenes**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- paradas: string[]
- comodidades: string[]
- disponibilidad: boolean

### 10. **Hospedaje**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- nombre_hospedaje: string
- direccion: string
- tipo: string
- capacidad: integer
- precio_noche: float
- servicios: string[]
- disponibilidad: boolean

### 11. **Habitaciones**
- id (PK): integer
- hospedaje_id (FK → Hospedaje.id): integer
- tipo: string
- capacidad: integer
- precio_noche: float
- comodidades: string[]
- disponibilidad: boolean

### 12. **Panorama**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- empresa: string
- nombre_panorama: string
- descripcion: string
- ubicacion: string
- duracion: integer
- precio_persona: float
- capacidad: integer
- restricciones: string[]

### 13. **Transporte**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- tipo_transporte: string
- empresa: string
- costo_total: float
- detalles: string

### 14. **Participante**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- nombre: string
- edad: integer
- tipo_documento: string
- numero_documento: string

### 15. **Destino**
- id (PK): integer
- nombre_destino: string
- pais: string
- ciudad: string
- descripcion: string
- popularidad: integer

### 16. **Itinerario**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- dia: date
- actividad: string
- lugar: string
- hora_inicio: time
- hora_fin: time

### 17. **Factura**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- usuario_id (FK → Usuario.id): integer
- fecha_emision: date
- total_pagado: float
- metodo_pago: string
- estado: string

## Relaciones Clave
- **Usuario - Agenda** (1:N) → Un usuario puede tener varias agendas.
- **Agenda - Reserva** (1:N) → Una agenda puede contener varias reservas.
- **Reserva - Seguro / Review / Transporte / Panorama / Participante / Factura** (1:N) → Una reserva puede estar asociada a múltiples registros en estas entidades.
- **Reserva - Medios de Transporte (Buses, Aviones, Trenes)** (1:1) → Una reserva puede estar vinculada a un solo medio de transporte.
- **Reserva - Hospedaje** (1:1) → Una reserva puede incluir un hospedaje.
- **Hospedaje - Habitaciones** (1:N) → Un hospedaje puede tener múltiples habitaciones.
- **Reserva - Itinerario** (1:N) → Una reserva puede tener un itinerario con múltiples actividades.
