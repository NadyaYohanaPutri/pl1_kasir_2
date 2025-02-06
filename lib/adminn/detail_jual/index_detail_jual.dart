import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/detail_jual/tombol_shopping_bag.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexDetailJual extends StatefulWidget {
  const IndexDetailJual({super.key});

  @override
  State<IndexDetailJual> createState() => _IndexDetailJualState();
}

class _IndexDetailJualState extends State<IndexDetailJual> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> detailpenjualan = [];

  @override
  void initState() {
    super.initState();
    fetchDetailPenjualan();
  }

  Future<void> fetchDetailPenjualan() async {
    try {
      final response = await supabase.from('detailpenjualan').select();
      setState(() {
        detailpenjualan = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching detail penjualan: $e');
    }
  }

  Future<void> insertDetailPenjualan( int Subtotal, int PelangganID) async {
    final supabase = Supabase.instance.client;
    
      final response = await supabase.from('detailpenjualan').insert({
        'PelangganID': PelangganID,
        'ToTalHarga': Subtotal,
      });
    if(response == null ){
      print('error');
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDAB9), Color(0xFFFFF9C4)], // Gradasi lembut background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: detailpenjualan.length,
          itemBuilder: (context, index) {
            final detail = detailpenjualan[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,  // Merapikan teks
                    children: [
                      Row(
                        children: [
                          Text('Detail ID: ${detail['DetailID']?.toString() ?? 'tidak tersedia'}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 28),
                          Text('Penjualan ID: ${detail['PenjualanID']?.toString() ?? 'tidak tersedia'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 28),
                          Text('Produk ID: ${detail['ProdukID']?.toString() ?? 'tidak tersedia'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 28),
                          Text('Jumlah Produk: ${detail['JumlahProduk']?.toString() ?? 'tidak tersedia'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 28),
                          Text('Subtotal: ${detail['Subtotal']?.toString() ?? 'tidak tersedia'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 28,),
                          IconButton(
                            onPressed: () async {
                              print('Tombol ditekan'); // Debugging untuk cek apakah onPressed dipanggil
                              final subtotal = detail['Subtotal'];
                              final pelangganID = detail['PelangganID'];

                              if (subtotal != null && pelangganID != null) {
                                await insertDetailPenjualan(subtotal, pelangganID);
                                Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => TombolShoppingBag(
                                    penjualan: subtotal,
                                    pelangganID: pelangganID,
                                  )),
                                );
                                } else {
                                  print('Data tidak valid');
                              }
                            },
                            icon: const Icon(Icons.shopping_bag, color: Color(0xFFFA7070),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
