<?php
$prefix = '../E0/CSV/';
$dir = new DirectoryIterator($prefix);

foreach ($dir as $fileinfo) {
    if ($fileinfo->isFile() && $fileinfo->getExtension() == 'csv') {
        $filepath = $fileinfo->getPathname();
        $csvfile = fopen($filepath, "r") or die("Unable to open file!");
        
        while (($data = fgetcsv($csvfile, 1000, ",")) !== FALSE) {
            print_r($data);
        }
        
        fclose($csvfile);
    }
}
            ?>