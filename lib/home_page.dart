import 'package:flutter/material.dart';
import 'package:pl1_kasir/main.dart';
import 'package:pl1_kasir/pengaturan/registrasi.dart';
import 'package:pl1_kasir/pengaturan/sattings.dart';
import 'package:pl1_kasir/tombol_homepage.dart/detail_jual/index_detail_jual.dart';
import 'package:pl1_kasir/tombol_homepage.dart/Pelanggan/index_pelanggan.dart';
import 'package:pl1_kasir/tombol_homepage.dart/produk/index_produk.dart';
import 'package:pl1_kasir/tombol_homepage.dart/penjualan/penjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    IndexDetailJual(),
    IndexProduk(),
    Penjualan(),
    IndexPelanggan(),
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
        backgroundColor: Color(0xFF2E7D32),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 80,
              child: DrawerHeader(
                child: ListTile(
                  leading: Icon(Icons.arrow_back_ios,),
                  title: Text('Pengaturan'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Registrasi'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Registrasi()));
              },
            ),
            SizedBox(height: 5,),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            )
          ],
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
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage),
            label: 'Produk',
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Penjualan',
            backgroundColor: Color(0xFF1B5E20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pelanggan',
            backgroundColor: Color(0xFF1B5E20),
          ),
        ],
      ),
    );
  }
}
