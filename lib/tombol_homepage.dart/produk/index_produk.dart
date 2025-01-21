import 'package:flutter/material.dart';
import 'package:pl1_kasir/tombol_homepage.dart/produk/insert_produk.dart';
import 'package:pl1_kasir/tombol_homepage.dart/produk/update_produk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexProduk extends StatefulWidget {
  const IndexProduk({super.key});

  @override
  _IndexProdukState createState() => _IndexProdukState();
}

class _IndexProdukState extends State<IndexProduk> {
  List<Map<String, dynamic>> produk = [];

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    try {
      final response = await Supabase.instance.client.from('produk').select();
      setState(() {
        produk = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching produk: $e');
    }
  }

  Future<void> deleteProduk(int id) async {
    try {
      await Supabase.instance.client.from('produk').delete().eq('ProdukID', id);
      fetchProduk();
    } catch (e) {
      print('Error deleting produk: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: produk.isEmpty
        ? Center(
            child: Text(
              'Tidak ada produk',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: produk.length,
            itemBuilder: (context, index) {
              final langgan = produk[index];
              return SizedBox(
                height: 145,
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Left Column for Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Text(
                                langgan['NamaProduk'] ?? 'Produk tidak tersedia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                langgan['Harga'] ?? 'Harga Tidak tersedia',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                langgan['Stok'] ?? 'Tidak tersedia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        // Right Column for Buttons
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue, size: 28),
                                  onPressed: () {
                                    final ProdukID = langgan['ProdukID'] ?? 0;
                                    if (ProdukID != 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateProduk(ProdukID: ProdukID,),
                                        ),
                                      );
                                    } else {
                                      print('ID produk tidak valid');
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Hapus Produk'),
                                          content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteProduk(produk['ProdukID']);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Hapus'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InsertProduk()));
      },
      backgroundColor: Color(0xFF2E7D32),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
  );
}

}

