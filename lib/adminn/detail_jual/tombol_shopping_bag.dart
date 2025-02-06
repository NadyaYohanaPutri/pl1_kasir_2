import 'package:flutter/material.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TombolShoppingBag extends StatefulWidget {
  final int penjualan;
  final int pelangganID;

  const TombolShoppingBag({Key? key, required this.penjualan, required this.pelangganID}) : super(key: key);

  @override
  State<TombolShoppingBag> createState() => _TombolShoppingBagState();
}

class _TombolShoppingBagState extends State<TombolShoppingBag> {
  
  Future<void> insertPenjualan(int Subtotal, int PelangganID) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.from('penjualan').insert({
        'PelangganID': PelangganID,
        'Subtotal': Subtotal,
      });

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesanan berhasil disimpan!')),
        );
        Navigator.pop(context);
      } 
    } catch (e) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.penjualan; // Mengambil subtotal dari widget.penjualan
    final pelangganID = widget.pelangganID; // Mengambil pelangganID dari widget.pelangganID
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDAB9), Color(0xFFFFF9C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Harga: Rp$subtotal', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  Text('ID Pelanggan: $pelangganID', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Pesan',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}