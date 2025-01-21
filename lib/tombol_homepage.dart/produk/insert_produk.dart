import 'package:flutter/material.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:pl1_kasir/tombol_homepage.dart/produk/index_produk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertProduk extends StatefulWidget {
  @override
  _InsertProdukState createState() => _InsertProdukState();
}

class _InsertProdukState extends State<InsertProduk> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;
  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text;
    final harga = _hargaController.text;
    final stok = _stokController.text;

    try {
      final response = await supabase.from('produk').insert({
        'NamaProduk': nama,
        'Harga': harga,
        'Stok': stok,
      }).select();

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil disimpan!')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
      appBar: AppBar(title: Text('Tambah Produk', style: TextStyle(color: Colors.white),),
      elevation: 0,
      backgroundColor: Color(0xFF2E7D32),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => IndexProduk()));
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
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Harga tidak boleh kosong' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _stokController,
                decoration: InputDecoration(
                  labelText: 'Stok ',
                  border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Stok  tidak boleh kosong' : null,
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