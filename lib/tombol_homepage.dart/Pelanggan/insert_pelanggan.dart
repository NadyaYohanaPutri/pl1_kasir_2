import 'package:flutter/material.dart';
import 'package:pl1_kasir/tombol_homepage.dart/Pelanggan/index_pelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertPelanggan extends StatefulWidget {
  @override
  _InsertPelangganState createState() => _InsertPelangganState();
}

class _InsertPelangganState extends State<InsertPelanggan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _nomorTeleponController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;
  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final nomorTelepon = _nomorTeleponController.text;

    try {
      final response = await supabase.from('pelanggan').insert({
        'NamaPelanggan': nama,
        'Alamat': alamat,
        'NomorTelepon': nomorTelepon,
      }).select();

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil disimpan!')),
        );
        Navigator.pop(context, {
          'Nama': nama,
          'Alamat': alamat,
          'Nomor Telepon': nomorTelepon,
        });
      } else {
        throw Exception('Gagal menyimpan data.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Pelanggan'),
      elevation: 0,
      backgroundColor: Color(0xFF2E7D32),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => IndexPelanggan()));
        },
      ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Alamat tidak boleh kosong' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Nomor Telepon tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveData, child: Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}