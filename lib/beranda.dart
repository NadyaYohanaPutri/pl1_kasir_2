import 'package:flutter/material.dart';
import 'package:pl1_kasir/login_page.dart';

class Beranda extends StatefulWidget{
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2E7D32),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
          size:  20,
          color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );
  }
}