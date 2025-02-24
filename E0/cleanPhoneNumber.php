<?php
// Open the CSV file
$inputFile = './CSV/UsuariosRescatados.csv';
$outputFile = './CSV/UsuariosRescatados_cleanPhone.csv';

if (($handle = fopen($inputFile, 'r')) !== FALSE) {
    $outputHandle = fopen($outputFile, 'w');
    
    // Loop through each line in the CSV file
    while (($data = fgetcsv($handle, 1000, ',')) !== FALSE) {
        // Check if the 5th element exists
        if (isset($data[5])) {
            // Remove the first character from the 5th element if it is a backslash
            if ($data[5][0] === '\\') {
                $data[5] = substr($data[5], 1);
            }
        }
        
        // Write the modified data to the output file
        fputcsv($outputHandle, $data);
    }
    fclose($handle);
    fclose($outputHandle);
} else {
    echo "Error opening the file.";
}
?>