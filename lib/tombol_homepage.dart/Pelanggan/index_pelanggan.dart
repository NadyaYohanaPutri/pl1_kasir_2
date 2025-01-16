import 'package:flutter/material.dart';
import 'package:pl1_kasir/tombol_homepage.dart/Pelanggan/insert_pelanggan.dart';
import 'package:pl1_kasir/tombol_homepage.dart/Pelanggan/update_pelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexPelanggan extends StatefulWidget {
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
      body: pelanggan.isEmpty
          ? Center(
              child: Text(
                'Tidak ada pelanggan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
              ),
              padding: EdgeInsets.all(8),
              itemCount: pelanggan.length,
              itemBuilder: (context, index) {
                final langgan = pelanggan[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          langgan['NamaPelanggan'] ?? 'Pelanggan tidak tersedia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          langgan['Alamat'] ?? 'Alamat Tidak tersedia',
                          style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 16, color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          langgan['NomorTelepon'] ?? 'Tidak tersedia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                final PelangganID = langgan['PelangganID'] ?? 0; // Pastikan ini sesuai dengan kolom di database
                                if (PelangganID != 0) {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => UpdatePelanggan()),
                                  );
                                } else {
                                  print('ID pelanggan tidak valid');
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
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
                                            deletePelanggan(langgan['PelangganID']);
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
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => InsertPelanggan()));
        },
        backgroundColor: Color(0xFF2E7D32),
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

