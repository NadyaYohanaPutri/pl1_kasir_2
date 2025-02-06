import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/pelanggan/index_pelanggan.dart';
import 'package:pl1_kasir/adminn/detail_jual/index_detail_jual.dart';
import 'package:pl1_kasir/adminn/penjualan/index_penjualan.dart';
import 'package:pl1_kasir/adminn/produk/index_produk.dart';
import 'package:pl1_kasir/adminn/registrasi/index_registrasi.dart';
import 'package:pl1_kasir/main.dart';

class HomePage extends StatefulWidget {
  final bool isPetugas;

  const HomePage({super.key, this.isPetugas = false});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFA7070),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFDAB9), Color(0xFFFFF9C4)], // Gradasi lembut background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 80,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFFFA7070)),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    title: const Text('Pengaturan', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: const Icon(Icons.store, color: Color(0xFFFA7070)),
                title: const Text('Produk', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexProduk()));
                },
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: const Icon(Icons.people, color: Color(0xFFFA7070)),
                title: const Text('Pelanggan', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexPelanggan()));
                },
              ),
              const SizedBox(height: 5),
              if (!widget.isPetugas)
              ListTile(
                leading: const Icon(Icons.receipt_long, color: Color(0xFFFA7070)),
                title: const Text('Penjualan', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexPenjualan()));
                },
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Color(0xFFFA7070)),
                title: const Text('Detail Penjualan', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexDetailJual()));
                },
              ),
              const SizedBox(height: 5),
              if (!widget.isPetugas) 
              ListTile(
                leading: const Icon(Icons.people, color: Color(0xFFFA7070)),
                title: const Text('Registrasi', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexRegistrasi()));
                },
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFFFA7070)),
                title: const Text('Logout', style: TextStyle(color: Color(0xFFFA7070))),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity, //lebar penuh
        height: double.infinity, //tinggi penuh
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDAB9), Color(0xFFFFF9C4)], // Gradasi lembut 
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('asset/image/logo.png'), // Pastikan jalurnya benar
                      fit: BoxFit.contain, // Agar gambar tidak terpotong
                    ),
                  ),
                ),
                const Text('SELAMAT DATANG', style: TextStyle(fontSize: 40, color: Color(0xFFFA7070), fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Mari pesan dengan klik tombol di atas, Kiri.', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Color(0xFFFA7070), fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
