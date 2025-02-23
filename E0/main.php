<?php
$prefix = '../E0/CSV/';
$dir = new DirectoryIterator($prefix);
require_once 'cleanCsvLineFromUsuariosCsv.php';
require_once 'cleanCsvLineFromEmpleadosCsv.php';

foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getExtension() == 'csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        
        while (($line = fgetcsv($csvfile)) !== FALSE) {
            $cleanedLineUsuarios = cleanCsvLineFromUsuariosCsv($line);
            $cleanedLineEmpleados = cleanCsvLineFromEmpleadosCsv($line);
        }
        
        fclose($csvfile);
    }
}
?>