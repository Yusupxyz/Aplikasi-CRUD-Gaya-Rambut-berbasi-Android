import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/gaya/gaya_screen.dart';

class TambahGayaScreen extends StatelessWidget {
  TambahGayaScreen({super.key});
  final TextEditingController _gayaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://devapp2024.000webhostapp.com/api/gaya';

  Future saveGaya() async {
    final response =
        await http.post(Uri.parse(url), body: {"gaya": _gayaController.text});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Tambah Gaya',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xffEB1616),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Data gaya rambut harus diisi";
                  }
                  return null;
                },
                controller: _gayaController,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Masukkan gaya"),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                 onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveGaya().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GayaScreen()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data berhasil disimpan")));
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
