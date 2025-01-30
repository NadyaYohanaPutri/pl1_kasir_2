import 'package:flutter/material.dart';
import 'package:pl1_kasir/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePetugas extends StatefulWidget {
  const HomePetugas({super.key});

  @override
  State<HomePetugas> createState() => _HomePetugasState();
}

class _HomePetugasState extends State<HomePetugas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(isPetugas: true,) // Pastikan parameter isPetugas bernilai true
    );
  }
}