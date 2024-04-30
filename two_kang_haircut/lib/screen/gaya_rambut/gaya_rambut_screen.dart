// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:two_kang_haircut/screen/gaya_rambut/edit_gaya_rambut_screen.dart';
import 'package:two_kang_haircut/screen/gaya_rambut/tambah_gaya_rambut_screen.dart';

class GayaRambutScreen extends StatelessWidget {
  const GayaRambutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [
      {
        'id': 0,
        'panjang': '10',
        'id_warna': '2',
        'tekstur': 'sedang',
        'id_gaya': '2',
        'sumber': 'pelanggan'
      },
      {
        'id': 1,
        'panjang': '5',
        'id_warna': '3',
        'tekstur': 'kasar',
        'id_gaya': '3',
        'sumber': 'katalog'
      },
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Data Gaya Rambut',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xffEB1616),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shadowColor: Colors.grey.shade300,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: RichText(
                                text: TextSpan(
                                    text: '${list[index]['id_gaya']}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                   TextSpan(
                                    text: '\nPanjang: ${list[index]["id_gaya"]} cm\nWarna: ${list[index]["id_warna"]}\nTekstur: ${list[index]["tekstur"]}\nSumber: ${list[index]["sumber"]}',
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
                                              const EditGayaRambutScreen()),
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
                                    print('data terhapus');
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
