import 'package:flutter/material.dart';
import 'package:pl1_kasir/adminn/registrasi/index_registrasi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateRegistrasi extends StatefulWidget {
  final int UserID;

  const UpdateRegistrasi({super.key, required this.UserID});

  @override
  State<UpdateRegistrasi> createState() => _UpdateRegistrasiState();
}

class _UpdateRegistrasiState extends State<UpdateRegistrasi> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _role = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadRegistrasi();
  }

  // Fungsi untuk memuat data user berdasarkan ID
  Future<void> _loadRegistrasi() async {
    final data = await Supabase.instance.client
        .from('user')
        .select()
        .eq('UserID', widget.UserID)
        .single();

    setState(() {
      _username.text = data['Username'] ?? '';
      _password.text = data['Password'] ?? '';
      _role.text = data['Role']?.toString() ?? '';
    });
  }

  Future<void> updateRegistrasi() async {
    if (_formKey.currentState!.validate()) {
      // Melakukan update data user ke database
      await Supabase.instance.client.from('user').update({
        'Username': _username.text,
        'Password': _password.text,
        'Role': _role.text,
      }).eq('UserID',widget.UserID);

      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const IndexRegistrasi()),
        (route) => false, // Hapus semua halaman sebelumnya
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFA7070),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => IndexRegistrasi()));
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
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _role,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Role tidak boleh kosong';
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
                    onPressed: updateRegistrasi,
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