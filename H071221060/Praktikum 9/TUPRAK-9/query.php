<?php
class MyQuery
{
  function __construct($conn)
  {
    $this->conn = $conn;
  }

  function show_data($input)
  {
    try {
      $arr = explode(", ", $input);
      echo "Daftar Orderan" . "\n";

      // Todo [1] : Buatkan query untuk menampilkan 5 data dari kolom inputan dan customernumber sebagai id yang berasal dari tabel customer dan orders  
      $sql = "SELECT distinct c.customernumber AS id, $input
      FROM customers c
      JOIN orders o 
      USING(customernumber)
      GROUP BY $input
      ORDER BY c.customernumber ASC
      LIMIT 5";

      $resultSet = array();
      // Jalankan Query dan Menampilkan
      $result = $this->conn->query($sql);

      if ($result) {
        if ($result->num_rows > 0) {
          $index = 1;
          foreach ($arr as $key => $value) {
            printf("   | %-33s", strtoupper($value));
          }
          printf("  |\n");
          while ($row = $result->fetch_array()) {
            $resultSet[$index] = $row['id'];
            printf("%d.", $index);
            for ($i = 0; $i < count($arr); $i++) {
              // Periksa apakah kolom ada sebelum mencoba mengaksesnya
              if (array_key_exists($arr[$i], $row)) {
                printf(" | %-35s", $row[$arr[$i]]);
              } else {
                printf(" | %-35s", "Kolom tidak ditemukan");
              }
            }
            printf("|\n");
            $index++;
          }
        } else {
          echo "Data tidak ditemukan";
        }
      }
    } catch (Exception $e) {
      echo "Terjadi kesalahan : " . $e->getMessage();
    }

    return $resultSet;
  }

  function update_name($kolom)
  {
    try {
      $arr = explode(", ", $kolom);

      // Tampilkan data dan pilih nama
      $list_id = $this->show_data($kolom);
      $input = null; // Ganti -1 dengan null

      echo "Tuliskan value yang hendak kamu ubah\n";
      $input = readline('> ');

      echo 'Input Value baru';
      $new_name = readline('> ');

      // TODO [2] tambahkan kode untuk menonaktifkan auto commit
      $this->conn->autocommit(0);

      // TODO [3] start transaction 
      $this->conn->begin_transaction();

      // TODO [4] Query untuk mengecek Apakah Nilai inputan Ada.
      $sql_check = "SELECT $kolom FROM customers WHERE $kolom = '$input'";
      $result_check = $this->conn->query($sql_check);

      if ($result_check->num_rows == 0) {
        echo "Data tidak ditemukan";
        $this->conn->rollback(); // Rollback transaksi jika data tidak ditemukan
        return;
      }

      // TODO [5] : Masukkan query untuk mengupdate nilai kolom berdasarkan inputan
      $sql = "UPDATE customers SET $kolom = '$new_name' WHERE $kolom = '$input'";
      $update_result = $this->conn->query($sql);

      echo "Daftar apa yang kamu mau lihat" . "\n";

      $this->show_data($kolom);
      while (true) {
        echo 'Simpan Perubahan?' . "\n" . '1. YES' . "\n" . '2. NO' . "\n";
        $choice = readline('> ');
        switch ($choice) {
          case 1:
            // TODO [6] : masukkan query untuk commit
            $this->conn->commit();
            return;
          case 2:
            // TODO [7] : masukkan query untuk rollback
            $this->conn->rollback();
            return;
          default:
            echo "Input Salah\n";
            break;
        }
      }
    } catch (Exception $e) {
      echo "Terjadi kesalahan: " . $e->getMessage();
    }
  }
}