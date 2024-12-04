import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipAsigurare extends StatefulWidget {
  const TipAsigurare({super.key});

  @override
  State<TipAsigurare> createState() => _TipAsigurareState();
}

class _TipAsigurareState extends State<TipAsigurare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Asigurare'),
      ),
    );
  }
}

