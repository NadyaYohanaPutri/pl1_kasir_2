import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/penjualan/index_penjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePenjualan extends StatefulWidget {
  final int PenjualanID;

  const UpdatePenjualan({super.key, required this.PenjualanID});

  @override
  State<UpdatePenjualan> createState() => _UpdatePenjualanState();
}

class _UpdatePenjualanState extends State<UpdatePenjualan> {
  final _tglPen = TextEditingController();
  final _totalHar = TextEditingController();
  final _idPel = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadPenjualan();
  }

  // Fungsi untuk memuat data penjualan berdasarkan ID
  Future<void> _loadPenjualan() async {
    final data = await Supabase.instance.client
        .from('penjualan')
        .select()
        .eq('PenjualanID', widget.PenjualanID)
        .single();

    setState(() {
      _tglPen.text = data['TanggalPenjualan'] ?? '';
      _totalHar.text = data['TotalHarga'] ?? '';
      _idPel.text = data['PelangganID']?.toString() ?? '';
    });
  }

  Future<void> updatePenjualan() async {
    if (_formKey.currentState!.validate()) {
      // Melakukan update data penjualan ke database
      await Supabase.instance.client.from('penjualan').update({
        'TanggalPenjualan': _tglPen.text,
        'TotalHarga': _totalHar.text,
        'PelangganID': _idPel.text,
      }).eq('PenjualanID',widget.PenjualanID);

      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const IndexPenjualan()),
        (route) => false, // Hapus semua halaman sebelumnya
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Penjualan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => const IndexPenjualan()));
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
                controller: _tglPen,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Penjualan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalHar,
                decoration: const InputDecoration(
                  labelText: 'Total Harga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idPel,
                decoration: const InputDecoration(
                  labelText: 'ID Pelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
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
                    onPressed: updatePenjualan,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 16),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
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