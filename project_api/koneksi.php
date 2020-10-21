<?php
$konek=mysqli_connect("localhost","root","","project_api");
if(mysqli_connect_errno()){
	echo "Koneksi database tidak berhasil : ".mysql_connect_error();
}