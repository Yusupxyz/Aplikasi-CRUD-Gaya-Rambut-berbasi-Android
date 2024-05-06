// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:two_kang_haircut/screen/gaya_rambut/gaya_rambut_screen.dart';
import 'package:two_kang_haircut/screen/gaya/gaya_screen.dart';
import 'package:two_kang_haircut/screen/wajah/wajah_screen.dart';
import 'package:two_kang_haircut/screen/warna/warna_screen.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Two Kang's Haircut",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
                height: 45, child: Image.asset('assets/images/logo.png')),
          )
        ],
        backgroundColor: const Color(0xffEB1616),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 33,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WarnaScreen()),
                  );
                },
                child: Container(
                  width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: const Icon(Icons.color_lens,
                            size: 100, color: Colors.red),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Basis Warna",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 33,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GayaScreen()),
                  );
                },
                child: Container(
                  width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: const Icon(Icons.face_retouching_natural,
                            size: 100, color: Colors.red),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Basis Gaya Rambut",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 33,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WajahScreen()),
                  );
                },
                child: Container(
                  width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: const Icon(Icons.sensor_occupied,
                            size: 100, color: Colors.red),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Data Wajah",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 33,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GayaRambutScreen()),
                  );
                },
                child: Container(
                  width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: const Icon(Icons.remember_me,
                            size: 100, color: Colors.red),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Data Gaya Rambut",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
