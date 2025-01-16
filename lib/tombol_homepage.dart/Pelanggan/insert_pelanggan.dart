import 'package:flutter/material.dart';
import 'package:pl1_kasir/tombol_homepage.dart/Pelanggan/index_pelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertPelanggan extends StatelessWidget {
  const InsertPelanggan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => IndexPelanggan()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}