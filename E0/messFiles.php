<?php
function dirtyCsvLineFromUsuariosCsv($line) {    
    // Ensuciar número de teléfono (alterar formato o valores)
    if (rand(0, 1)) {
        $line[6] = "+" . rand(50, 99) . " " . rand(1000, 9999) . " " . rand(1000, 9999);
    }
    
    // Ensuciar correo (agregar espacios, caracteres inválidos o quitar '@')
    if (rand(0, 1)) {
        $line[4] = str_replace("@", "", $line[4]) . " example";
    }
    
    // Ensuciar fecha (cambiar formato o agregar letras)
    if (rand(0, 1)) {
        $line[8] = "fecha-" . rand(1, 12) . "-" . rand(2020, 2030);
    }
    
    // Ensuciar monto (hacerlo negativo)
    if (rand(0, 1)) {
        $line[9] = -abs($line[9]);
    }
    
    // Ensuciar RUN (agregar puntos o valores fuera del rango)
    if (rand(0, 1)) {
        $line[1] = number_format(rand(10000, 35000000), 0, '', '.');
    }
    
    return $line;
}

function dirtyCsvLineFromEmpleadosCsv($line) {    
    // Ensuciar número de teléfono
    if (rand(0, 1)) {
        $line[5] = "56 " . rand(1, 9) . " " . rand(1000, 9999) . " " . rand(1000, 9999);
    }
    
    // Ensuciar correo
    if (rand(0, 1)) {
        $line[3] = "correo_sin_arroba.com";
    }
    
    // Ensuciar fecha
    if (rand(0, 1)) {
        $line[9] = rand(1, 31) . "/" . rand(1, 12) . "/" . rand(2020, 2030);
    }
    
    // Ensuciar monto (hacerlo negativo)
    if (rand(0, 1)) {
        $line[10] = -abs($line[10]);
    }
    
    // Ensuciar RUN
    if (rand(0, 1)) {
        $line[1] = "99.999.999-K";
    }
    
    // Ensuciar lugares (convertir a minúsculas o agregar caracteres raros)
    if (rand(0, 1)) {
        $line[13] = strtolower($line[13]) . "#";
    }
    if (rand(0, 1)) {
        $line[14] = strtoupper($line[14]) . "!!!";
    }
    
    return $line;
}

$prefix = '../E0/CSV/';
$dir = new DirectoryIterator($prefix);

foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getFilename() == 'EmpleadosRescatados.csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        $dirtyFilepath = $prefix . 'EmpleadosRescatados_dirty.csv';
        $dirtyCsvfile = fopen($dirtyFilepath, "w") or die("Unable to open file!");
        # Skip header
        $header = fgetcsv($csvfile);
        fputcsv($dirtyCsvfile, $header);

        while (($line = fgetcsv($csvfile)) !== FALSE) {
            $dirtyLine = dirtyCsvLineFromEmpleadosCsv($line);
            fputcsv($dirtyCsvfile, $dirtyLine);
        }

        fclose($csvfile);
        fclose($dirtyCsvfile);
    }
}
foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getFilename() == 'UsuariosRescatados.csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        $dirtyFilepath = $prefix . 'UsuariosRescatados_dirty.csv';
        $dirtyCsvfile = fopen($dirtyFilepath, "w") or die("Unable to open file!");
        # Skip header
        $header = fgetcsv($csvfile);
        fputcsv($dirtyCsvfile, $header);

        while (($line = fgetcsv($csvfile)) !== FALSE) {
            $dirtyLine = dirtyCsvLineFromUsuariosCsv($line);
            fputcsv($dirtyCsvfile, $dirtyLine);
        }

        fclose($csvfile);
        fclose($dirtyCsvfile);
    }
}
?>
