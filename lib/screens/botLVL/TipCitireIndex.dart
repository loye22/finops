import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipCitireIndex extends StatefulWidget {
  const TipCitireIndex({super.key});

  @override
  State<TipCitireIndex> createState() => _TipCitireIndexState();
}

class _TipCitireIndexState extends State<TipCitireIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Citire Index'),
      ),
    );
  }
}
