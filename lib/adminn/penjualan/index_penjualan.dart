import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/penjualan/insert_penjualan.dart';
import 'package:pl1_kasir/adminn/penjualan/update_penjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexPenjualan extends StatefulWidget {
  const IndexPenjualan({super.key});

  @override
  State<IndexPenjualan> createState() => _IndexPenjualanState();
}

class _IndexPenjualanState extends State<IndexPenjualan> {
  List<Map<String, dynamic>> penjualan = [];

  @override
  void initState() {
    super.initState();
    fetchPenjualan();
  }

  Future<void> fetchPenjualan() async {
    try {
      final response = await Supabase.instance.client.from('penjualan').select();
      setState(() {
        penjualan = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching penjualan: $e');
    }
  }

  Future<void> deletePenjualan(int id) async {
    try {
      await Supabase.instance.client.from('penjualan').delete().eq('PenjualanID', id);
      fetchPenjualan();
    } catch (e) {
      print('Error deleting penjualan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDAB9), Color(0xFFFFF9C4)], // Gradasi lembut background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: penjualan.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ada penjualan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: penjualan.length,
                itemBuilder: (context, index) {
                  final langgan = penjualan[index];
                  return SizedBox(
                    height: 145,
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Left Column for Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    langgan['TanggalPenjualan'] ??
                                        'Tidak tersedia',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    langgan['TotalHarga'] ??
                                        'Tidak tersedia',
                                    style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    langgan['PelangganID'] ??
                                        'Tidak tersedia',
                                    style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 14),
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
                                        final PenjualanID =
                                            langgan['PenjualanID'] ?? 0;
                                        if (PenjualanID != 0) {
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => UpdatePenjualan(PenjualanID: PenjualanID),),);
                                        } else {
                                          print('ID Penjualan tidak valid');
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
                                              title: const Text('Hapus Penjualan'),
                                              content: const Text('Apakah Anda yakin ingin menghapus penjualan ini?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Batal'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    deletePenjualan(
                                                        langgan['PenjualanID']);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const InsertPenjualan()));
        },
        backgroundColor: const Color(0xFFFA7070),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}