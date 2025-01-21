import os
import csv
from faker import Faker
from random import choice, randint

# Inicializar Faker
fake = Faker()

# Directorio donde se encuentran los archivos CSV
csv_directory = "./CSV"

# Generadores de datos reutilizables
empresa_nombres = [fake.company() for _ in range(50)]  # Generar 50 nombres de empresas y reutilizarlos
ciudades = [fake.city() for _ in range(50)]  # Generar 50 nombres de ciudades
comentarios = [
    "Excelente experiencia, todo salió perfecto.",
    "No fue lo que esperaba, pero estuvo bien.",
    "Servicio al cliente muy amable y atento.",
    "Las instalaciones estaban limpias y cómodas.",
    "El proceso de reserva fue muy sencillo.",
    "Hubo problemas con el horario, pero lo solucionaron.",
    "Definitivamente lo recomendaría a amigos.",
    "No volvería a usar este servicio, muy decepcionante.",
    "Todo estuvo increíble, especialmente el trato del personal.",
    "Fue una experiencia promedio, nada especial.",
]

# IDs compartidos entre tablas
servicio_ids = [randint(1, 5000) for _ in range(1000)]  # IDs comunes para servicios

# Función para generar datos para cada archivo
def generate_data_for_csv(filename, rows=1000):
    schema_generators = {
        "airbnb": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            choice(servicio_ids),  # servicioId relacionado
            fake.name(),  # nombre_hospedador
            randint(1, 10),  # capacidad
            ";".join(fake.words(nb=5)),  # comodidades
            round(fake.random.uniform(1.0, 5.0), 1),  # calificacion
        ],
        "detallesReserva": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            randint(1, 10000),  # reservaId relacionado
            choice(servicio_ids),  # servicioId relacionado
            randint(1, 5),  # cantidad_reservada
            round(fake.random.uniform(50.0, 1000.0), 2),  # monto_reserva
        ],
        "entretenimientos": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            choice(servicio_ids),  # servicioId relacionado
            choice(["Cine", "Teatro", "Concierto", "Deporte", "Museo"]),  # tipo
            fake.date_between(start_date="-1y", end_date="today").strftime("%Y-%m-%d"),  # fecha
            fake.time(),  # hora
        ],
        "hotel": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            choice(servicio_ids),  # servicioId relacionado
            round(fake.random.uniform(1.0, 5.0), 1),  # calificacion
            randint(1, 200),  # habitaciones_disponibles
            fake.country(),  # pais
            choice(ciudades),  # ciudad
            fake.address(),  # direccion
            ";".join(fake.words(nb=5)),  # comodidades
        ],
        "opiniones": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            randint(1, 5000),  # usuarioId relacionado
            choice(servicio_ids),  # servicioId relacionado
            round(fake.random.uniform(1.0, 5.0), 1),  # calificacion
            choice(comentarios),  # comentario
        ],
        "reservas": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            randint(1, 5000),  # usuarioId relacionado
            fake.date_between(start_date="-1y", end_date="today").strftime("%Y-%m-%d"),  # fecha
            choice(["confirmada", "cancelada", "pendiente"]),  # estado
            round(fake.random.uniform(50.0, 5000.0), 2),  # monto_total
        ],
        "servicios": lambda: [
            choice(servicio_ids),  # id (IDs compartidos con otras tablas)
            choice(["Airbnb", "Hotel", "Vuelo", "Transporte", "Entretenimiento"]),  # tipo
            choice(empresa_nombres),  # nombre
            choice(ciudades),  # ubicacion
            round(fake.random.uniform(10.0, 1000.0), 2),  # precio
        ],
        "transportes": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            choice(servicio_ids),  # servicioId relacionado
            choice(["Bus", "Tren", "Taxi", "Barco"]),  # tipo
            choice(ciudades),  # origen
            choice(ciudades),  # destino
        ],
        "usuario": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            fake.name(),  # nombre
            fake.email(),  # correo
            fake.password(),  # contrasena
            fake.phone_number(),  # telefono
        ],
        "vuelos": lambda: [
            fake.unique.random_int(1, 10000),  # id único
            choice(servicio_ids),  # servicioId relacionado
            choice(empresa_nombres),  # aerolinea
            choice(ciudades),  # origen
            choice(ciudades),  # destino
            fake.time(),  # hora_salida
            fake.time(),  # hora_llegada
            fake.bothify("###-??"),  # numero_vuelo
        ],
    }

    # Inferir el nombre del esquema basado en el archivo
    base_name = os.path.splitext(os.path.basename(filename))[0]
    if base_name not in schema_generators:
        print(f"Esquema desconocido para {base_name}, saltando...")
        return

    # Generar datos basados en el esquema
    generator = schema_generators[base_name]
    data = [generator() for _ in range(rows)]

    # Leer encabezados del archivo
    with open(filename, "r", encoding="utf-8") as csvfile:
        reader = csv.reader(csvfile, delimiter=";")
        headers = next(reader)  # Leer los encabezados

    # Escribir datos nuevos en el archivo
    with open(filename, "w", newline="", encoding="utf-8") as csvfile:
        writer = csv.writer(csvfile, delimiter=";")
        writer.writerow(headers)  # Escribir encabezados
        writer.writerows(data)  # Escribir datos generados

    print(f"Archivo {filename} rellenado con {rows} filas.")

# Procesar todos los archivos CSV en el directorio
if not os.path.exists(csv_directory):
    print(f"El directorio {csv_directory} no existe.")
else:
    for file in os.listdir(csv_directory):
        if file.endswith(".csv"):
            file_path = os.path.join(csv_directory, file)
            generate_data_for_csv(file_path, rows=1000)  # Cambia el número de filas según sea necesario
