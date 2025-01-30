import 'package:flutter/material.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertPenjualan extends StatefulWidget {
  const InsertPenjualan({super.key});

  @override
  State<InsertPenjualan> createState() => _InsertPenjualanState();
}

class _InsertPenjualanState extends State<InsertPenjualan> {
  final _formKey = GlobalKey<FormState>();
  final _tglController = TextEditingController();
  final _totalController = TextEditingController();
  final _plnggnIdController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final tanggal = _tglController.text;
    final total = _totalController.text;
    final pelangganid = _plnggnIdController.text;

    try {
      final response = await supabase.from('penjualan').insert({
        'TanggalPenjualan': tanggal,
        'TotalHarga': total,
        'PelangganID': pelangganid,
      }).select();

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan!')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
      appBar: AppBar(
        title: const Text(
          'Tambah Penjualan',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => const InsertPenjualan()));
          },
        ),
      ),
      body: Container(
        // Adding the gradient decoration here
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
                controller: _tglController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Penjualan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Tanggal tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _totalController,
                decoration: const InputDecoration(
                  labelText: 'Total Harga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Total tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _plnggnIdController,
                decoration: const InputDecoration(
                  labelText: 'ID Pelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'ID Pelanggan tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
              onPressed: _saveData,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA7070),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}