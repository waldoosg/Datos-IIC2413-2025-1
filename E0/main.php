<?php
$prefix = '../E0/CSV/';
$dir = new DirectoryIterator($prefix);
require_once 'cleaningFunctions.php';

$lineas_cambiadas = 0;

foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getFilename() == 'EmpleadosRescatados_dirty.csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        $cleanedFilepath = $prefix . 'EmpleadosRescatados_cleaned.csv';
        $cleanedCsvfile = fopen($cleanedFilepath, "w") or die("Unable to open file!");
        # Skip header
        $header = fgetcsv($csvfile);
        fputcsv($cleanedCsvfile, $header);

        while (($line = fgetcsv($csvfile)) !== FALSE) {
            $cleanedLine = cleanCsvLineFromEmpleadosCsv($line);
            fputcsv($cleanedCsvfile, $cleanedLine);
            if ($line != $cleanedLine) {
                $lineas_cambiadas++;
            }
        }
        print_r("Las lineas cambiadas fueron: " . $lineas_cambiadas . "\n");

        fclose($csvfile);
        fclose($cleanedCsvfile);
    }
}
$lineas_cambiadas = 0;
foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getFilename() == 'UsuariosRescatados_dirty.csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        $cleanedFilepath = $prefix . 'UsuariosRescatados_cleaned.csv';
        $cleanedCsvfile = fopen($cleanedFilepath, "w") or die("Unable to open file!");
        # Skip header
        $header = fgetcsv($csvfile);
        fputcsv($cleanedCsvfile, $header);


        while (($line = fgetcsv($csvfile)) !== FALSE) {
            $cleanedLine = cleanCsvLineFromUsuariosCsv($line);
            fputcsv($cleanedCsvfile, $cleanedLine);
            if ($line != $cleanedLine) {
                $lineas_cambiadas++;
            }
        }

        print_r("Las lineas cambiadas fueron: " . $lineas_cambiadas . "\n");
        fclose($csvfile);
        fclose($cleanedCsvfile);
    }
}
?>