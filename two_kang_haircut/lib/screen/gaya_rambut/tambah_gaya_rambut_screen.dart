import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/gaya_rambut/gaya_rambut_screen.dart';

class TambahGayaRambutScreen extends StatefulWidget {
  const TambahGayaRambutScreen({super.key});

  @override
  State<TambahGayaRambutScreen> createState() => _TambahGayaRambutScreenState();
}

class _TambahGayaRambutScreenState extends State<TambahGayaRambutScreen> {

  List<DropdownMenuItem<String>> get teksturItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "kasar", child: Text("Kasar")),
      const DropdownMenuItem(value: "sedang", child: Text("Sedang")),
      const DropdownMenuItem(value: "halus", child: Text("Halus")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get sumberItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "katalog", child: Text("Katalog")),
      const DropdownMenuItem(value: "pelanggan", child: Text("Pelanggan")),
    ];
    return menuItems;
  }

  String? selectedWarna;
  String? selectedTekstur;
  String? selectedGaya;
  String? selectedSumber;
  final TextEditingController _panjangController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://10.0.2.2:8000/api/gayarambut';
  final String urlGaya = 'http://10.0.2.2:8000/api/gaya';
  final String urlWarna = 'http://10.0.2.2:8000/api/warna';

  Future saveGayaRambut() async {
    final response = await http
        .post(Uri.parse(url), body: {
          "panjang": _panjangController.text,
          "id_warna": selectedWarna,
          "tekstur": selectedTekstur,
          "id_gaya": selectedGaya,
          "sumber": selectedSumber
          });
    return json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> getGaya() async {
    http.Response response = await http.get(Uri.parse(urlGaya));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['data'] is List) {
        List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
            jsonData['data'].map((item) => item as Map<String, dynamic>));
        return items;
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to fetch styles');
    }
  }

  Future<List<Map<String, dynamic>>> getWarna() async {
    http.Response response = await http.get(Uri.parse(urlWarna));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['data'] is List) {
        List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
            jsonData['data'].map((item) => item as Map<String, dynamic>));
        return items;
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to fetch styles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Tambah Data Gaya Rambut',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getGaya(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> data = snapshot.data!;
                    return DropdownButton<String>(
                      value: selectedGaya,
                      hint: const Text('Pilih Gaya Rambut'),
                      items: data.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item['id'].toString(),
                          child: Text(item['gaya']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGaya = newValue;
                        });
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Data panjang harus diisi";
                  }
                  return null;
                },
                controller: _panjangController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Masukkan panjang dalam cm"),
              ),
              const SizedBox(
                height: 12,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getWarna(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> data = snapshot.data!;
                    return DropdownButton<String>(
                      value: selectedWarna,
                      hint: const Text('Pilih Warna'),
                      items: data.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item['id'].toString(),
                          child: Text(item['warna']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWarna = newValue;
                        });
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              DropdownButton(
                value: selectedTekstur,
                hint: const Text('Pilih Tekstur'),
                items: teksturItems,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTekstur = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              DropdownButton(
                value: selectedSumber,
                hint: const Text('Pilih Sumber'),
                items: sumberItems,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSumber = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveGayaRambut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GayaRambutScreen()));
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
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
