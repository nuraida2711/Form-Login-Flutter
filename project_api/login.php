<?php
//Menghubungkan dengan database
include 'koneksi.php';
//Mengambil data yang dikirim
$nama=$_POST['pengguna'];
$sandi=$_POST['sandi'];

//melakukan query
$data=mysqli_query($konek,"select * from pengguna where nama='$nama' AND sandi='$sandi'");
$cek=mysqli_num_rows($data);
if($cek>0){
	$response="login berhasil";
	echo json_encode($response);
}else{
	$response="login gagal";
	echo json_encode($response);
}