// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:two_kang_haircut/screen/gaya/edit_gaya_screen.dart';
import 'package:two_kang_haircut/screen/gaya/tambah_gaya_screen.dart';

class GayaScreen extends StatelessWidget {
  const GayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [
      {
        'id': 0,
        'gaya': 'Muhawk',
      },
      {
        'id': 1,
        'gaya': 'Wolf Cut',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Basis Gaya Rambut',
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
                                    text: 'Warna: ',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                  TextSpan(text: list[index]['gaya'])
                                ])),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditGayaScreen()),
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
                        builder: (context) => const TambahGayaScreen()),
                  );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}