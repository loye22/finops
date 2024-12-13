import 'package:finops/provider/BankProvider.dart';
import 'package:finops/provider/DocumentProvider.dart';
import 'package:finops/provider/EntityTypeProvider.dart';
import 'package:finops/provider/OperationTypeProvider.dart';
import 'package:finops/screens/homeScreen.dart';
import 'package:finops/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/MonedaProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyAsFiCZMpxZ8bOT_hV3FTEmHsxWmXkU_Vk",
        authDomain: "finops-ab505.firebaseapp.com",
        projectId: "finops-ab505",
        storageBucket: "finops-ab505.firebasestorage.app",
        messagingSenderId: "484004696644",
        appId: "1:484004696644:web:09c8f72318b43d610c2211",
        measurementId: "G-Z65544W2T9"),
  );
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OperationTypeProvider()),
    ChangeNotifierProvider(create: (context) => DocumentProvider()),
    ChangeNotifierProvider(create: (context) => EntityTypeProvider()),
    ChangeNotifierProvider(create: (context) => BankNameProvider()),
    ChangeNotifierProvider(create: (context) => MonedaProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.transparent, // Remove splash effect color
          highlightColor: Colors.transparent, // Remove highlight effect color
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return homeScreen();
          } else {
            return loginScreen();
          }
        },
      ),
      routes: {},
    );
  }
}
