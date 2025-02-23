<?php
function cleanCsvLineFromUsuariosCsv($line) {
  $line = explode(",", $line);
  // 0. Nombre
  // 1. Run
  // 2. Dv
  // 3. Correo
  // 4. Contrasena
  // 5. Telefono contacto
  // 6. Puntos
  // 7. Etiqueta
  // 8. Fecha
  // 9. Monto
  // 10. Cantidad personas

  // Limpiar número telefono (tiene formato +569 XXXX XXXX)
  if (!preg_match('/^\+569 \d{4} \d{4}$/', $line[6])) {
    $line[7] = null;
  }

  // Limpiar correo (alfanumérico, mínimo de longitud de 4, tiene que tener @, sin espacios y .com/.cl/etc)
  if (!preg_match('/^[a-zA-Z0-9._%+-]{4,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/', $line[4])) {
    $line[3] = null;
  }

  // Limpiar fecha (solo puede tener numeros y guiones, tiene que ser formato Date, sin letras)
  if (!preg_match('/^\d{2}-\d{2}-\d{4}$/', $line[8])) {
    $line[8] = null;
  }

  // Limpiar monto (no puede ser negativo)
  if ($line[9] < 0) {
    $line[9] = abs($line[9]);
  }

  // Limpiar run (no puede ser menor a 200000 ni mayor a 30000000, tiene que ser númerico y sin puntos, si los tiene se sacan)
  if (!is_numeric($line[1]) || $line[1] < 200000 || $line[1] > 30000000) {
    $line[1] = null;
  }

  return $line;
}

function cleanCsvLineFromEmpleadosCsv($line) {
  $line = explode(",", $line);
  // 0. Nombre
  // 1. Run
  // 2. Dv
  // 3. Correo
  // 4. Contrasena
  // 5. Telefono contacto
  // 6. Jornada
  // 7. Isapre
  // 8. Contrato
  // 9. Fecha
  // 10. Monto
  // 11. Cantidad personas
  // 12. Numero viaje
  // 13. Lugar origen
  // 14. Lugar llegada
  // 15. Capacidad
  // 16. Tiempo estimado
  // 17. Precio asiento
  // 18. Empresa
  // 19. Tipo de bus
  // 20. Comodidades
  // 21. Escalas
  // 22. Clase
  // 23. Paradas

  // Limpiar número telefono (tiene formato 56 X XXXX XXXX)
  if (!preg_match('/^56 \d \d{4} \d{4}$/', $line[5])) {
    $line[5] = null;
  }

  // Limpiar correo (alfanumérico, mínimo de longitud de 4, tiene que tener @, sin espacios y .com/.cl/etc)
  if (!preg_match('/^[a-zA-Z0-9._%+-]{4,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/', $line[3])) {
    $line[3] = null;
  }

  // Limpiar fecha (solo puede tener numeros y guiones, tiene que ser formato Date, sin letras)
  if (!preg_match('/^\d{2}-\d{2}-\d{4}$/', $line[9])) {
    $line[9] = null;
  }

  // Limpiar monto (no puede ser negativo)
  if ($line[10] < 0) {
    $line[10] = abs($line[10]);
  }

  // Limpiar run (no puede ser menor a 200000 ni mayor a 30000000, tiene que ser númerico y sin puntos, si los tiene se sacan)
  if (!is_numeric($line[1]) || $line[1] < 200000 || $line[1] > 30000000) {
    $line[1] = null;
  }

  // Limpiar lugar origen (la ciudad y pais deben venir capitalizadas)
  if ($line[13] !== ucwords(strtolower($line[13]))) {
    $line[13] = ucwords(strtolower($line[13]));
  }
  
  // Limpiar lugar llegada (la ciudad y pais deben venir capitalizadas)
  if ($line[14] !== ucwords(strtolower($line[14]))) {
    $line[14] = ucwords(strtolower($line[14]));
  }

  return $line;
}
?>