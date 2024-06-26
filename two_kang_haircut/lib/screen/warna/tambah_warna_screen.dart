// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/warna/warna_screen.dart';

class TambahWarnaScreen extends StatelessWidget {
  TambahWarnaScreen({super.key});

  final TextEditingController _warnaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://devapp2024.000webhostapp.com/api/warna';

  Future saveWarna() async {
    final response =
        await http.post(Uri.parse(url), body: {"warna": _warnaController.text});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Tambah Warna',
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
                    return "Data warna harus diisi";
                  }
                  return null;
                },
                controller: _warnaController,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Masukkan warna"),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveWarna().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WarnaScreen()));
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
