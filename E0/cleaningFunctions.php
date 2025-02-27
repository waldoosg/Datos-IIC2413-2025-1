<?php
function cleanCsvLineFromUsuariosCsv($line) {
    // Limpiar número de teléfono
    $line[6] = str_replace("-", " ", $line[6]);
    if (!preg_match('/^\+569 \d{4} \d{4}$/', $line[6])) {
        $line[6] = null;
    }

    // Limpiar correo
    $line[3] = str_replace('@@', '@', $line[3]);
    if (!preg_match('/^[a-zA-Z0-9._%+-]{4,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/', $line[3])) {
        $line[3] = null;
    }
    if (strpos($line[3], ".ceele") !== false) {
        $line[3] = null;
    }

    // Limpiar fecha
    $line[9] = str_replace("/", "-", $line[9]);
    if (!preg_match('/^\d{2}-\d{2}-\d{4}$/', $line[9])) {
        $line[9] = null;
    }

    // Limpiar monto
    $line[10] = abs((int)$line[10]);

    // Limpiar RUN
    $line[1] = preg_replace('/[^0-9kK]/', '', $line[1]);
    if (!is_numeric($line[1]) || $line[1] < 200000 || $line[1] > 30000000) {
        $line[1] = null;
    }
    
    return $line;
}

function cleanCsvLineFromEmpleadosCsv($line) {
    // Limpiar número de teléfono
    $line[6] = str_replace("-", " ", $line[6]);
    if (!preg_match('/^56 \d \d{4} \d{4}$/', $line[6])) {
        $line[6] = null;
    }

    // Limpiar correo
    $line[3] = str_replace('@@', '@', $line[3]);
    if (!preg_match('/^[a-zA-Z0-9._%+-]{4,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/', $line[3])) {
        $line[3] = null;
    }
    if (strpos($line[3], ".ceele") !== false) {
        $line[3] = null;
    }

    // Limpiar fecha
    $line[10] = str_replace("/", "-", $line[10]);
    print($line[10] . "\n");
    if (!preg_match('/^\d{2}-\d{2}-\d{4}$/', $line[10])) {
        $line[10] = null;
    }

    // Limpiar monto
    $line[11] = abs((int)$line[11]);

    // Limpiar RUN
    $line[1] = preg_replace('/[^0-9kK]/', '', $line[1]);
    if (!is_numeric($line[1]) || $line[1] < 200000 || $line[1] > 30000000) {
        $line[1] = null;
    }

    // Limpiar lugar origen y llegada
    $line[15] = ucwords(strtolower(preg_replace('/[^a-zA-Z ]/', '', $line[15])));
    $line[16] = ucwords(strtolower(preg_replace('/[^a-zA-Z ]/', '', $line[16])));
    
    return $line;
}
?>
