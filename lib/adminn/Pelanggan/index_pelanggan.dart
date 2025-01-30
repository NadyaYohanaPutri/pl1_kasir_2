import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/Pelanggan/insert_pelanggan.dart';
import 'package:pl1_kasir/adminn/Pelanggan/update_pelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexPelanggan extends StatefulWidget {
  const IndexPelanggan({super.key});

  @override
  _IndexPelangganState createState() => _IndexPelangganState();
}

class _IndexPelangganState extends State<IndexPelanggan> {
  List<Map<String, dynamic>> pelanggan = [];

  @override
  void initState() {
    super.initState();
    fetchPelanggan();
  }

  Future<void> fetchPelanggan() async {
    try {
      final response = await Supabase.instance.client.from('pelanggan').select();
      setState(() {
        pelanggan = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching pelanggan: $e');
    }
  }

  Future<void> deletePelanggan(int id) async {
    try {
      await Supabase.instance.client.from('pelanggan').delete().eq('PelangganID', id);
      fetchPelanggan();
    } catch (e) {
      print('Error deleting pelanggan: $e');
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
        child: pelanggan.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ada pelanggan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: pelanggan.length,
                itemBuilder: (context, index) {
                  final langgan = pelanggan[index];
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
                                    langgan['NamaPelanggan'] ??
                                        'Pelanggan tidak tersedia',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    langgan['Alamat'] ??
                                        'Alamat Tidak tersedia',
                                    style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    langgan['NomorTelepon'] ??
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
                                        final PelangganID =
                                            langgan['PelangganID'] ?? 0;
                                        if (PelangganID != 0) {
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>UpdatePelanggan(PelangganID: PelangganID),),);
                                        } else {
                                          print('ID pelanggan tidak valid');
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
                                              title: const Text('Hapus Pelanggan'),
                                              content: const Text('Apakah Anda yakin ingin menghapus pelanggan ini?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Batal'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    deletePelanggan(
                                                        langgan['PelangganID']);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertPelanggan()));
        },
        backgroundColor: const Color(0xFFFA7070),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
