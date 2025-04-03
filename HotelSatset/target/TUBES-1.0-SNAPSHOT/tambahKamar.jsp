<%-- 
    Document   : tambahKamar
    Created on : Jan 7, 2025, 3:05:51 AM
    Author     : Ando Holle
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Kamar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F8F4E3;
            margin: 50px auto;
        }

        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Tambah Kamar Baru</h1>
        <form action="RoomController" method="POST">
            <div class="mb-3">
                <label for="tipeKamar" class="form-label">Tipe Kamar</label>
                <input type="text" class="form-control" id="tipe_kamar" name="tipe_kamar" placeholder="Masukkan tipe kamar (e.g., Standard, Deluxe)" required>
            </div>
            <div class="mb-3">
                <label for="harga" class="form-label">Harga</label>
                <input type="number" class="form-control" id="harga" name="harga" placeholder="Masukkan harga kamar" required>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Simpan</button>
            </div>
        </form>
    </div>
</body>
</html>
