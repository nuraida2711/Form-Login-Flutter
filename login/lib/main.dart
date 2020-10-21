import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login Aplikasi';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          title: Center(child: Text(appTitle)),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String nama = "nama", sandi = "sandi";
  final kontrolernama = TextEditingController();
  final kontrollersandi = TextEditingController();

  login() async {
    // SERVER LOGIN API URL
    var url = 'http://10.254.20.50/project_api/login.php';
    // POST KE SISTEM
    var response =
        await http.post(url, body: {'pengguna': nama, 'sandi': sandi});

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if (message == 'login berhasil') {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Login Berhasil"),
          );
        },
      );
    } else if (message == "login Tidak Berhasil") {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Maaf Anda Tidak Diijinkan Masuk"),
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Respon Tidak Dikenali"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: kontrolernama,
            decoration: const InputDecoration(hintText: "Naman Pengguna"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Data Anda Belum Lengkap';
              }
              return null;
            },
          ),
          //ini untuk intupan password
          TextFormField(
            controller: kontrollersandi,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Masukkan Sandi"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Data Anda Belum Lengkap';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    nama = kontrolernama.text.trim();
                    sandi = kontrollersandi.text.trim();
                    login();
                  },
                  child: Text('Login'),
                ),
              )),
        ],
      ),
    );
  }
}
