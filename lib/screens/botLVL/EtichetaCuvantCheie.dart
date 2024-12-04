import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EtichetaCuvantCheie extends StatefulWidget {
  const EtichetaCuvantCheie({super.key});

  @override
  State<EtichetaCuvantCheie> createState() => _EtichetaCuvantCheieState();
}

class _EtichetaCuvantCheieState extends State<EtichetaCuvantCheie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Eticheta Cuvant Cheie'),
      ),
    );
  }
}
