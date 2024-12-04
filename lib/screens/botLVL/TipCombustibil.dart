import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipCombustibil extends StatefulWidget {
  const TipCombustibil({super.key});

  @override
  State<TipCombustibil> createState() => _TipCombustibilState();
}

class _TipCombustibilState extends State<TipCombustibil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Combustibil'),
      ),
    );
  }
}
