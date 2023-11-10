<?php
include 'query.php';

$servername = 'localhost';
$username = 'root';
$password = '';
$dbnama = 'classicmodels';

// Melakukan koneksi ke database
$conn = new mysqli($servername, $username, $password, $dbnama);

// Mengecek apakah koneksi error atau tidak
if ($conn->connect_error) {
  die('Connection failed: ' . $conn->connect_error);
}

// start function
$query = new MyQuery($conn);
while (true) {
  echo 'Tugas Praktikum 9' . "\r\n";
  echo '1. Tampilkan 5 Data' . "\n";
  echo '2. Update Kolom' . "\n";
  echo '0. Keluar' . "\n";
  $input = (int)readline('> ');
  switch ($input) {
    case 0:
      return;
    case 1:
      echo "Pilih Kolom yang mau ditampilkan\n";
      $input = readline('> ');
      
      $query->show_data($input);
      echo "\n";
      break;
    case 2:
      echo "Pilih kolom dari customers yang hendak kamu ubah\n";
      $kolom = readline('> ');
      $query->update_name($kolom);
      echo "\n";
      break;
    default:
      break;
  }
}
