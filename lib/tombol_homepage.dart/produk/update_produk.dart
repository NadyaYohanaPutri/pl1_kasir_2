import 'package:flutter/material.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProduk extends StatefulWidget {
  final int ProdukID;

  const UpdateProduk({super.key, required this.ProdukID});

  @override
  State<UpdateProduk> createState() => _UpdateProdukState();
}

class _UpdateProdukState extends State<UpdateProduk> {
  final _nmplg = TextEditingController();
  final _alamat = TextEditingController();
  final _notlp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadProdukData();
  }

  // Fungsi untuk memuat data pelanggan berdasarkan ID
  Future<void> _loadProdukData() async {
    final data = await Supabase.instance.client
        .from('detailproduk')
        .select()
        .eq('ProdukID', widget.ProdukID)
        .single();

    setState(() {
      _nmplg.text = data['NamaProduk'] ?? '';
      _alamat.text = data['Alamat'] ?? '';
      _notlp.text = data['NomorTelepon'] ?? '';
    });
  }

Future<void> UpdateProduk() async {
  if (_formKey.currentState!.validate()) {
    await Supabase.instance.client.from('detailproduk').update({
      'NamaProduk': _nmplg.text,
      'Alamat': _alamat.text,
      'NomorTelepon': _notlp.text,
    }).eq('ProdukID', widget.ProdukID);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false, // Hapus semua halaman sebelumnya
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nmplg,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: UpdateProduk,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}