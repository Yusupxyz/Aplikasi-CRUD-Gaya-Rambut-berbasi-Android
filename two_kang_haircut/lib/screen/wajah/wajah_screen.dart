// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:two_kang_haircut/screen/wajah/edit_wajah_screen.dart';
import 'package:two_kang_haircut/screen/wajah/tambah_wajah_screen.dart';

class WajahScreen extends StatelessWidget {
  const WajahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [
      {
        'id': 0,
        'nama': 'Andi',
        'wajah':
            'https://akcdn.detik.net.id/community/media/visual/2019/02/19/42393387-9c5c-4be4-97b8-49260708719e.jpeg',
      },
      {
        'id': 1,
        'nama': 'Bunga',
        'wajah':
            'https://img-highend.okezone.com/okz/900/pictureArticle/images_3C38pt5T_m4d44b.jpg',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Wajah',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                list[index]['wajah'],
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
                                  TextSpan(text: list[index]['nama'])
                                ])),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditWajahScreen()),
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
            MaterialPageRoute(builder: (context) => const TambahWajahScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
