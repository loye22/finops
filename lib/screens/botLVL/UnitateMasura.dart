import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnitateMasura extends StatefulWidget {
  const UnitateMasura({super.key});

  @override
  State<UnitateMasura> createState() => _UnitateMasuraState();
}

class _UnitateMasuraState extends State<UnitateMasura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Unitate de Masura'),
      ),
    );
  }
}
