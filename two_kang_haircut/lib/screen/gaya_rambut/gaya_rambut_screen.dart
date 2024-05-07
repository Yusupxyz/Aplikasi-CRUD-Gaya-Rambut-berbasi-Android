// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:two_kang_haircut/main.dart';
import 'package:two_kang_haircut/screen/gaya_rambut/edit_gaya_rambut_screen.dart';
import 'package:two_kang_haircut/screen/gaya_rambut/tambah_gaya_rambut_screen.dart';
import 'package:http/http.dart' as http;

class GayaRambutScreen extends StatefulWidget {
  const GayaRambutScreen({super.key});

  @override
  State<GayaRambutScreen> createState() => _GayaRambutScreenState();
}

class _GayaRambutScreenState extends State<GayaRambutScreen> {
  @override
  Widget build(BuildContext context) {
    const String url = 'http://devapp2024.000webhostapp.com/api/gayarambut';
    const String urlDelete = 'http://devapp2024.000webhostapp.com/api/gayarambut/delete';

    Future getGayaRambut() async {
      var response = await http.get(Uri.parse(url));
      return json.decode(response.body);
    }

    Future deleteGayaRambut(String id) async {
      var response = await http.post(Uri.parse("$urlDelete/$id"));
      return json.decode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Data Gaya Rambut',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xffEB1616),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainApp()),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: getGayaRambut(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shadowColor: Colors.grey.shade300,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: RichText(
                                text: TextSpan(
                                    text:
                                        '${snapshot.data['data'][index]['gaya']['gaya']}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text:
                                          '\nPanjang: ${snapshot.data['data'][index]["panjang"]} cm\nWarna: ${snapshot.data['data'][index]["warna"]['warna']}\nTekstur: ${StringUtils.capitalize("${snapshot.data['data'][index]["tekstur"]}")}\nSumber: ${StringUtils.capitalize("${snapshot.data['data'][index]["sumber"]}")}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal)),
                                ])),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditGayaRambutScreen(
                                                gayaRambut: snapshot
                                                    .data['data'][index],
                                              )),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Apakah Anda yakin?'),
                                        content: const Text(
                                            'Aksi ini akan menghapus data secara permanen'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Hapus'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (result == null || !result) {
                                      return;
                                    }
                                    //disini api hapus dieksekusi
                                    deleteGayaRambut(snapshot.data['data']
                                                [index]['id']
                                            .toString())
                                        .then((value) {
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Data berhasil dihapus")));
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Text('Data kosong');
              }
            }),
      ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TambahGayaRambutScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
