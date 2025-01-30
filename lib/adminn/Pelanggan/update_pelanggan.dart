import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/Pelanggan/index_pelanggan.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePelanggan extends StatefulWidget {
  final int PelangganID;

  const UpdatePelanggan({super.key, required this.PelangganID});

  @override
  State<UpdatePelanggan> createState() => _UpdatePelangganState();
}

class _UpdatePelangganState extends State<UpdatePelanggan> {
  final _nmplg = TextEditingController();
  final _alamat = TextEditingController();
  final _notlp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadPelangganData();
  }

  // Fungsi untuk memuat data pelanggan berdasarkan ID
  Future<void> _loadPelangganData() async {
    final data = await Supabase.instance.client
        .from('pelanggan')
        .select()
        .eq('PelangganID', widget.PelangganID)
        .single();

    setState(() {
      _nmplg.text = data['NamaPelanggan'] ?? '';
      _alamat.text = data['Alamat'] ?? '';
      _notlp.text = data['NomorTelepon']?.toString() ?? '';
    });
  }

  // UpdatePelanggan.dart
  Future<void> updatePelanggan() async {
    if (_formKey.currentState!.validate()) {
      // Melakukan update data pelanggan ke database
      await Supabase.instance.client.from('pelanggan').update({
        'NamaPelanggan': _nmplg.text,
        'Alamat': _alamat.text,
        'NomorTelepon': _notlp.text,
      }).eq('PelangganID', widget.PelangganID);

      // Navigasi ke PelangganTab setelah update, dengan menghapus semua halaman sebelumnya dari stack
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false, // Hapus semua halaman sebelumnya
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pelanggan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => IndexPelanggan()));
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nmplg,
                decoration: const InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamat,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notlp,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updatePelanggan,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFFFA7070),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
