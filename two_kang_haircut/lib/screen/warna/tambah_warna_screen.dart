import 'package:flutter/material.dart';

class TambahWarnaScreen extends StatelessWidget {
  const TambahWarnaScreen({super.key});

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
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Masukkan warna"),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: null,
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
      )),
    );
  }
}
