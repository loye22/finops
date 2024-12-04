import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumeBanca extends StatefulWidget {
  const NumeBanca({super.key});

  @override
  State<NumeBanca> createState() => _NumeBancaState();
}

class _NumeBancaState extends State<NumeBanca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Nume Banca'),
      ),
    );
  }
}
