import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipVacanta extends StatefulWidget {
  const TipVacanta({super.key});

  @override
  State<TipVacanta> createState() => _TipVacantaState();
}

class _TipVacantaState extends State<TipVacanta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Vacanta'),
      ),
    );
  }
}
