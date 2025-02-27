<?php
function dirtyCsvLineFromUsuariosCsv($line) {    
    // Ensuciar número de teléfono (alterar formato o valores)
    if (rand(0, 99) < 20) {
        $line[6] = str_replace(" ", "-", $line[6]);
    }
    
    // Ensuciar correo (agregar espacios, caracteres inválidos o quitar '@')
    if (rand(0, 99) < 20) {
        if (rand(0, 99) < 50) {
            $line[3] = str_replace("@", "", $line[3]);
        } else {
            $line[3] = str_replace("@", "@@", $line[3]);
        }
    }

    // Ensuciar dominio del correo (reemplazar ".xxx" con algo específico)
    if (rand(0, 99) < 20) {
        $emailParts = explode("@", $line[3]);
        if (count($emailParts) == 2) {
            $domainParts = explode(".", $emailParts[1]);
            if (count($domainParts) > 1) {
                $domainParts[count($domainParts) - 1] = "ceele";
                $emailParts[1] = implode(".", $domainParts);
                $line[3] = implode("@", $emailParts);
            }
        }
    }
    
    // Ensuciar fecha (cambiar formato o agregar letras)
    if (rand(0, 99) < 20) {
        $line[9] = str_replace("-", "/", $line[9]);
    }
    
    // Ensuciar monto (hacerlo negativo)
    if (rand(0, 99) < 20) {
        $line[10] = (int)$line[10];
        $line[10] = -abs($line[10]);
        $line[10] = (string)$line[10];
    }
    
    // Ensuciar RUN (agregar puntos o valores fuera del rango)
    if (rand(0, 99) < 20) {
        $line[1] = addDotsToRut($line[1]);
    }

    return $line;
}
function addDotsToRut($rut) {
    $rut = preg_replace('/[^kK0-9]/', '', $rut); // Remove any non-numeric or non-K/k characters
    if (strlen($rut) == 8) {
        return substr($rut, 0, 2) . '.' . substr($rut, 2, 3) . '.' . substr($rut, 5, 3);
    } elseif (strlen($rut) == 7) {
        return substr($rut, 0, 1) . '.' . substr($rut, 1, 3) . '.' . substr($rut, 4, 3);
    }
    return $rut; // Return the original RUT if it doesn't match expected lengths
}

function dirtyCsvLineFromEmpleadosCsv($line) {    
    // Ensuciar número de teléfono (alterar formato o valores)
    if (rand(0, 99) < 20) {
        $line[6] = str_replace(" ", "-", $line[6]);
    }
    
    // Ensuciar correo (agregar espacios, caracteres inválidos o quitar '@')
    if (rand(0, 99) < 20) {
        if (rand(0, 99) < 50) {
            $line[3] = str_replace("@", "", $line[3]);
        } else {
            $line[3] = str_replace("@", "@@", $line[3]);
        }
    }

    // Ensuciar dominio del correo (reemplazar ".xxx" con algo específico)
    if (rand(0, 99) < 20) {
        $emailParts = explode("@", $line[3]);
        if (count($emailParts) == 2) {
            $domainParts = explode(".", $emailParts[1]);
            if (count($domainParts) > 1) {
                $domainParts[count($domainParts) - 1] = "ceele";
                $emailParts[1] = implode(".", $domainParts);
                $line[3] = implode("@", $emailParts);
            }
        }
    }
    
    // Ensuciar fecha (cambiar formato o agregar letras)
    if (rand(0, 99) < 20) {
        $line[10] = str_replace("-", "/", $line[10]);
    }
    
    // Ensuciar monto (hacerlo negativo)
    if (rand(0, 99) < 20) {
        $line[11] = (int)$line[11];
        $line[11] = -abs($line[11]);
        $line[11] = (string)$line[11];
    }
    
    // Ensuciar RUN (agregar puntos o valores fuera del rango)
    if (rand(0, 99) < 20) {
        $line[1] = addDotsToRut($line[1]);
    }

    // Ensuciar lugares (convertir a minúsculas o agregar caracteres raros)
    if (rand(0, 99) < 20) {
        $line[15] = strtolower($line[15]) . "#";
    }
    if (rand(0, 99) < 20) {
        $line[16] = strtoupper($line[16]) . "!!!";
    }
    return $line;
}

$prefix = '../E0/CSV/';
$dir = new DirectoryIterator($prefix);

$archivos = [
    'EmpleadosRescatados_cleanPhone.csv' => 'EmpleadosRescatados_dirty.csv',
    'UsuariosRescatados_cleanPhone.csv' => 'UsuariosRescatados_dirty.csv'
];

foreach ($archivos as $cleanFile => $dirtyFile) {
    foreach ($dir as $fileinfo) {
        if ($fileinfo->isFile() && $fileinfo->getFilename() == $cleanFile) {
            $filepath = $fileinfo->getPathname();
            $csvfile = fopen($filepath, "r") or die("Unable to open file!");
            $dirtyFilepath = $prefix . $dirtyFile;
            $dirtyCsvfile = fopen($dirtyFilepath, "w") or die("Unable to open file!");

            // Contadores
            $lineas_ensuciadas = 0;
            $lineas_sin_cambios = 0;

            // Saltar encabezado
            $header = fgetcsv($csvfile);
            fputcsv($dirtyCsvfile, $header);

            while (($line = fgetcsv($csvfile)) !== FALSE) {
                $dirtyLine = ($cleanFile == 'EmpleadosRescatados_cleanPhone.csv') 
                    ? dirtyCsvLineFromEmpleadosCsv($line)
                    : dirtyCsvLineFromUsuariosCsv($line);

                fputcsv($dirtyCsvfile, $dirtyLine);

                if ($line != $dirtyLine) {
                    $lineas_ensuciadas++;
                } else {
                    $lineas_sin_cambios++;
                }
            }

            fclose($csvfile);
            fclose($dirtyCsvfile);

            // Imprimir resumen
            echo "Archivo: $dirtyFile\n";
            echo "Líneas ensuciadas: $lineas_ensuciadas\n";
            echo "Líneas sin cambios: $lineas_sin_cambios\n";
            echo "------------------------\n";
        }
    }
}
?>
