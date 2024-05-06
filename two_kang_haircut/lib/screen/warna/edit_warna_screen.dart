import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/warna/warna_screen.dart';

class EditWarnaScreen extends StatelessWidget {
  final Map warna;
  EditWarnaScreen({super.key, required this.warna});
  final TextEditingController _warnaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://devapp2024.000webhostapp.com/api/warna';

  Future updateWarna() async {
    // ignore: unused_local_variable
    final response = await http.put(Uri.parse("$url/${warna['id']}"),
        body: {"warna": _warnaController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Ubah Warna',
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
                controller: _warnaController..text = warna['warna'],
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
                    updateWarna().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WarnaScreen()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data berhasil diubah")));
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Ubah',
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
