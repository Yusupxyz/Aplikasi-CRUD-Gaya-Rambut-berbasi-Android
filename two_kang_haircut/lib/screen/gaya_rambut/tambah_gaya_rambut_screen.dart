import 'package:flutter/material.dart';

class TambahGayaRambutScreen extends StatefulWidget {
  const TambahGayaRambutScreen({super.key});

  @override
  State<TambahGayaRambutScreen> createState() => _TambahGayaRambutScreenState();
}

class _TambahGayaRambutScreenState extends State<TambahGayaRambutScreen> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "2", child: Text("Biru")),
      const DropdownMenuItem(value: "3", child: Text("Kuning")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get teksturItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "kasar", child: Text("Kasar")),
      const DropdownMenuItem(value: "sedang", child: Text("Sedang")),
      const DropdownMenuItem(value: "halus", child: Text("Halus")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get gayaItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "2", child: Text("Wavy Long Hair")),
      const DropdownMenuItem(value: "3", child: Text("Muhawk")),
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

  String? selectedValue;
  String? selectedTekstur;
  String? selectedGaya;
  String? selectedSumber;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              value: selectedGaya,
              hint: const Text('Pilih Gaya Rambut'),
              items: gayaItems,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Masukkan panjang dalam cm"),
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownButton(
              value: selectedValue,
              hint: const Text('Pilih Warna'),
              items: dropdownItems,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
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
                  selectedValue = newValue!;
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
                  selectedValue = newValue!;
                });
              },
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
}
