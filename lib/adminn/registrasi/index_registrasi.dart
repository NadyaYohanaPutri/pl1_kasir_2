import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/registrasi/insert_registrasi.dart';
import 'package:pl1_kasir/adminn/registrasi/update_registrasi.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexRegistrasi extends StatefulWidget {
  const IndexRegistrasi({super.key});

  @override
  State<IndexRegistrasi> createState() => _IndexRegistrasiState();
}

class _IndexRegistrasiState extends State<IndexRegistrasi> {
  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    super.initState();
    fetchRegis();
  }

  Future<void> fetchRegis() async {
    try {
      final response = await Supabase.instance.client.from('user').select();
      setState(() {
        user = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<void> deleteRegis(int id) async {
    try {
      await Supabase.instance.client.from('user').delete().eq('UserID', id);
      fetchRegis();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFA7070),
        title: Text('Data User', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
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
        child: user.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ada user',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: user.length,
                itemBuilder: (context, index) {
                  final langgan = user[index];
                  return SizedBox(
                    height: 145,
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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
                                    langgan['Username'] ??
                                        'Username tidak tersedia',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    langgan['Password'] ??
                                        'Password Tidak tersedia',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    langgan['Role'] ??
                                        'Tidak tersedia',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
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
                                      icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 28),
                                      onPressed: () {
                                        final UserID =
                                            langgan['UserID'] ?? 0;
                                        if (UserID != 0) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateRegistrasi(UserID: UserID),
                                            ),
                                          );
                                        } else {
                                          print('ID user tidak valid');
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 28),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Hapus User'),
                                              content: const Text(
                                                  'Apakah Anda yakin ingin menghapus user ini?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Batal'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    deleteRegis(
                                                        langgan['UserID']);
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InsertRegistrasi()));
        },
        backgroundColor: const Color(0xFFFA7070),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}