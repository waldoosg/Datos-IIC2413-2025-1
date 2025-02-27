# Esquema Relacional del Sistema de Reservas de Viajes

## Entidades y Atributos

### 1. **Persona**
- id (PK): integer
- nombre: string
- correo (único): string
- contrasena: string
- username: string
- telefono_contacto: string
- run: integer
- dv: integer

### 2. **Usuario**
- id (PK): integer
- nombre: string
- correo (único): string
- contrasena: string
- username: string
- telefono_contacto: string
- run: integer
- dv: integer
- puntos: integer

### 3. **Empleado**
- id (PK): integer
- nombre: string
- correo (único): string
- contrasena: string
- username: string
- telefono_contacto: string
- run: integer
- dv: integer
- jornada: string
- contrato: string
- isapre: string

### 4. **Agenda**
- id (PK): integer
- etiqueta: string
- usuario_id (FK → Usuario.id): integer

### 5. **Reserva**
- id (PK): integer
- agenda_id (FK → Agenda.id): integer
- fecha: date
- monto: float
- cantidad_personas: integer
- estado_disponibilidad: string

### 6. **Seguro**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- usuario_id (FK → Usuario.id): integer
- nombre: string
- tipo: string
- valor: float
- clausula: string
- empresa: string

### 7. **Review**
- id (PK): integer
- reserva_id (FK → Reserva.id): integer
- usuario_id (FK → Usuario.id): integer
- estrellas: float
- descripcion: string

### 8. **Buses**
- id (PK): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- fecha_salida: date
- fecha_llegada: date
- tipo: string
- comodidades: string[]

### 9. **Aviones**
- id (PK): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- fecha_salida: date
- fecha_llegada: date
- clase: string
- escalas: string[]

### 10. **Trenes**
- id (PK): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- fecha_salida: date
- fecha_llegada: date
- paradas: string[]
- comodidades: string[]

### 11. **Hospedaje**
- id (PK): integer
- nombre_hospedaje: string
- ubicacion: string
- precio_noche: float
- estrellas: float
- comodidades: string[]
- fecha_checkin: date
- fecha_checkout: date

### 12. **Hotel**
- id (PK): integer
- nombre_hospedaje: string
- ubicacion: string
- precio_noche: float
- estrellas: float
- comodidades: string[]
- fecha_checkin: date
- fecha_checkout: date
- politicas: string[]

### 13. **Airbnb**
- id (PK): integer
- nombre_hospedaje: string
- ubicacion: string
- precio_noche: float
- estrellas: float
- comodidades: string[]
- fecha_checkin: date
- fecha_checkout: date
- nombre_anfitrion: string
- contacto_anfitrion: string
- descripcion: string
- piezas: integer
- camas: integer
- banos: integer

### 14. **Habitaciones**
- id (PK): integer
- hotel_id (FK → Hotel.id): integer
- tipo: string
- numero_habitacion: integer

### 15. **Panorama**
- id (PK): integer
- empresa: string
- nombre_panorama: string
- descripcion: string
- ubicacion: string
- duracion: integer
- precio_persona: float
- capacidad: integer
- restricciones: string[]
- fecha_panorama: date

### 16. **Participante**
- id (PK): integer
- panorama_id (FK → Panorama.id): integer
- nombre_participante: string

### 17. **Transporte**
- id (PK): integer
- empleado_id (FK → Empleado.id): integer
- numero_viaje (único): integer
- lugar_origen: string
- lugar_llegada: string
- capacidad: integer
- tiempo_estimado: integer
- precio_asiento: float
- empresa: string
- fecha_salida: date
- fecha_llegada: date
