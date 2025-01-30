import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/Pelanggan/index_pelanggan.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const IndexDetailJual(),
    const IndexProduk(),
    const IndexPenjualan(),
    const IndexPelanggan(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                    title: const Text(
                      'Pengaturan',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
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
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFFFA7070)),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Detail Jualan',
            backgroundColor: Color(0xFFFA7070)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Buah',
            backgroundColor: Color(0xFFFA7070)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Penjualan',
            backgroundColor: Color(0xFFFA7070)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pelanggan',
            backgroundColor: Color(0xFFFA7070)
          ),
        ],
      ),
    );
  }
}
