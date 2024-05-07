import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/gaya_rambut/gaya_rambut_screen.dart';

class EditGayaRambutScreen extends StatefulWidget {
  final Map gayaRambut;
  const EditGayaRambutScreen({super.key, required this.gayaRambut});

  @override
  State<EditGayaRambutScreen> createState() => _EditGayaRambutScreenState();
}

class _EditGayaRambutScreenState extends State<EditGayaRambutScreen> {
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
  final String url = 'http://devapp2024.000webhostapp.com/api/gayarambut/update';
  final String urlGaya = 'http://devapp2024.000webhostapp.com/api/gaya';
  final String urlWarna = 'http://devapp2024.000webhostapp.com/api/warna';

  Future updateGayaRambut() async {
    final response =
        await http.post(Uri.parse("$url/${widget.gayaRambut['id']}"), body: {
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
  void initState() {
    super.initState();
    selectedWarna = '${widget.gayaRambut['id_warna']}';
    selectedGaya = '${widget.gayaRambut['id_gaya']}';
    selectedTekstur = '${widget.gayaRambut['tekstur']}';
    selectedSumber = '${widget.gayaRambut['sumber']}';
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
                controller: _panjangController
                  ..text = '${widget.gayaRambut['panjang']}',
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
                      updateGayaRambut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GayaRambutScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data berhasil diubah")));
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
