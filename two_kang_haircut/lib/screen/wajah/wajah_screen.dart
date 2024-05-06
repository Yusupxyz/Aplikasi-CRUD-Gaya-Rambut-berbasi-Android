// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:two_kang_haircut/main.dart';
import 'package:two_kang_haircut/screen/wajah/edit_wajah_screen.dart';
import 'package:two_kang_haircut/screen/wajah/tambah_wajah_screen.dart';
import 'package:http/http.dart' as http;

class WajahScreen extends StatefulWidget {
  const WajahScreen({super.key});

  @override
  State<WajahScreen> createState() => _WajahScreenState();
}

class _WajahScreenState extends State<WajahScreen> {
  final String url = 'http://10.0.2.2:8000/api/wajah';
  final String urlStorage = 'http://10.0.2.2:8000/images/';

  Future getWajah() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future deleteWajah(String id) async {
    var response = await http.delete(Uri.parse("$url/$id"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Data Wajah',
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
            future: getWajah(),
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
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                urlStorage +
                                    snapshot.data['data'][index]['wajah'],
                                height: 150.0,
                                width: 100.0,
                              ),
                            ),
                            title: RichText(
                                text: TextSpan(
                                    text: 'Nama: ',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text: snapshot.data['data'][index]
                                          ['nama'])
                                ])),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditWajahScreen(
                                              wajah: snapshot.data['data']
                                                  [index])),
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
                                    deleteWajah(snapshot.data['data'][index]
                                                ['id']
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
            MaterialPageRoute(builder: (context) => const TambahWajahScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
