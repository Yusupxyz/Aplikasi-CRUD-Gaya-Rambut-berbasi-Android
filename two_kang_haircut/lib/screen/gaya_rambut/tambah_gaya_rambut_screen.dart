// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/gaya_rambut/gaya_rambut_screen.dart';
import 'package:two_kang_haircut/service/chatgpt_service.dart';

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
  String? selectedWarnaText;
  String? selectedTekstur;
  String? selectedWajah;
  String? selectedWajahUrl;
  final TextEditingController _panjangController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://devapp2024.000webhostapp.com/api/gayarambut';
  final String urlWajah = 'http://devapp2024.000webhostapp.com/api/wajah';
  final String urlWarna = 'http://devapp2024.000webhostapp.com/api/warna';

  Future saveGayaRambut() async {
    final response = await http.post(Uri.parse(url), body: {
      "panjang": _panjangController.text,
      "id_warna": selectedWarna,
      "tekstur": selectedTekstur,
      "id_wajah": selectedWajah,
      "rekomendasi_ai": _response,
    });
    return json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> getWajah() async {
    http.Response response = await http.get(Uri.parse(urlWajah));

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

  final ChatGPTService _chatGPTService = ChatGPTService(
      'sk-proj-VS4WX7ibge0v1e0T4pmxT3BlbkFJ2Cbh9MRAn3IQjGIm3PwV');
  String _response = '';

  void _sendMessage() async {
    print('sini');
    final userInput =
        'Rekomendasi gaya rambut dengan tekstur $selectedTekstur, warna rambut $selectedWarnaText, jenis kelamin laki-laki, panjang rambut sekitar ${_panjangController.text} cm dan bentuk wajah seperti gambar.';
    print(userInput);
    final url = 'https://devapp2024.000webhostapp.com/images/$selectedWajahUrl';
    print(url);

    final response = await _chatGPTService.getResponse(userInput, url);
    // final response = userInput;
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Rekomendasi Gaya Rambut',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xffEB1616),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: getWajah(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> data = snapshot.data!;
                      return DropdownButton<String>(
                        value: selectedWajah,
                        hint: const Text('Pilih Foto'),
                        items: data.map((Map<String, dynamic> item) {
                          return DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(item['nama']),
                            onTap: () {
                              setState(() {
                                selectedWajah = item['id'].toString();
                                selectedWajahUrl = item['wajah'];
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWajah = newValue;
                          });
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: selectedWajahUrl != null
                      ? Image.network(
                          'https://devapp2024.000webhostapp.com/images/$selectedWajahUrl',
                          height: 200,
                        )
                      : const Text('Tidak Ada Foto Terpilih'),
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
                      hintText: "Masukkan perkiraan panjang rambut dalam cm"),
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
                            onTap: () {
                              setState(() {
                                selectedWarna = item['id'].toString();
                                selectedWarnaText = item['warna'];
                              });
                            },
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _sendMessage();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: const Text(
                      'Rekomendasi Gaya Rambut dari AI',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (_response.isNotEmpty)
                  Card(
                    color: Colors.amber,
                    elevation: 4.0, // Tingkat elevasi untuk memberikan efek bayangan
                    margin: const EdgeInsets.all(8.0), // Margin di sekitar card
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Padding di dalam card
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            _response,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            speed: const Duration(milliseconds: 100), // Kecepatan ketik
                          ),
                        ],
                        isRepeatingAnimation: false, // Hanya animasi sekali
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                if (_response != '')
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveGayaRambut().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GayaRambutScreen()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Data berhasil disimpan")));
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text(
                        'Simpan Hasil Rekomendasi AI',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
