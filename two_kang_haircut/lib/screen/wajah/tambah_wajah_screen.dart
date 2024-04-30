import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TambahWajahScreen extends StatefulWidget {
  const TambahWajahScreen({super.key});
  @override
  State<TambahWajahScreen> createState() => _TambahWajahScreenState();
}

class _TambahWajahScreenState extends State<TambahWajahScreen> {
  File? _image;
  final picker = ImagePicker();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Color(0xffb2b2b2)),
                  hintText: "Masukkan nama pelanggan"),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Foto Wajah',
              style: TextStyle(fontSize: 16, color: Color(0xffb2b2b2)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const ContinuousRectangleBorder(),
                elevation: 0,
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: showOptions,
              child: const Text('Ambil Foto', style: TextStyle(
                fontSize: 16,
                color: Colors.white
              ),),
            ),
            Center(
              // ignore: unnecessary_null_comparison
              child: _image == null
                  ? const Text('Tidak Ada Gambar')
                  : SizedBox(width: 200, child: Image.file(_image!)),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: ElevatedButton(
                onPressed: null,
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
      )),
    );
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
