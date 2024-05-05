// ignore_for_file: no_logic_in_create_state, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:two_kang_haircut/screen/wajah/wajah_screen.dart';

class EditWajahScreen extends StatefulWidget {
  final Map wajah;
  const EditWajahScreen({super.key, required this.wajah});

  @override
  State<EditWajahScreen> createState() => _EditWajahScreenState();
}

class _EditWajahScreenState extends State<EditWajahScreen> {
  final TextEditingController _wajahController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String url = 'http://10.0.2.2:8000/api/wajah';

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _wajahController.text = widget.wajah['nama'];
  }

  Future updateWajah() async {
    var uri = Uri.parse("$url/${widget.wajah['id']}");
    var request = http.MultipartRequest('POST', uri);

    request.fields['nama'] = _wajahController.text;

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'wajah',
        _image!.path,
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return json.decode(responseString);
    } else {
      throw Exception('Gagal menyimpan data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Ubah Data Wajah',
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
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Data nama harus diisi";
                  }
                  return null;
                },
                controller: _wajahController,
                decoration: const InputDecoration(
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
                style: ElevatedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  elevation: 0,
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: showOptions,
                child: const Text(
                  'Ganti Foto',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateWajah().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WajahScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data berhasil diubah")));
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Gagal menyimpan data: $error")));
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
              getImageFromGallery().then((_) {
                Navigator.of(context).pop();
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              getImageFromCamera().then((_) {
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
    );
  }
}
