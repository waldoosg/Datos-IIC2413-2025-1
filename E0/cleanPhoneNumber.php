<?php
// Open the CSV file
$inputFile = './CSV/UsuariosRescatados.csv';
$outputFile = './CSV/UsuariosRescatados_cleanPhone.csv';

if (($handle = fopen($inputFile, 'r')) !== FALSE) {
    $outputHandle = fopen($outputFile, 'w');
    
    // Loop through each line in the CSV file
    while (($data = fgetcsv($handle, 1000, ',')) !== FALSE) {
        // Check if the 5th element exists
        if (isset($data[6])) {
            // Remove the first character from the 5th element if it is a backslash
            if ($data[6][0] === '\\') {
                $data[6] = substr($data[6], 1);
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