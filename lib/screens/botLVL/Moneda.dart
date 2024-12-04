import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Moneda extends StatefulWidget {
  const Moneda({super.key});

  @override
  State<Moneda> createState() => _MonedaState();
}

class _MonedaState extends State<Moneda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Moneda'),
      ),
    );
  }
}
