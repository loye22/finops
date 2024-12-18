import 'package:finops/provider/botLVL/BankNameProvider.dart';
import 'package:finops/provider/botLVL/CategoryTagProvider.dart';
import 'package:finops/provider/botLVL/ConsumptionLocationProvider.dart';
import 'package:finops/provider/botLVL/DocumentClassProvider.dart';
import 'package:finops/provider/botLVL/DocumentProvider.dart';
import 'package:finops/provider/botLVL/EntityTypeProvider.dart';
import 'package:finops/provider/botLVL/FuelTypeProvider.dart';
import 'package:finops/provider/botLVL/IndexReadingTypeProvider.dart';
import 'package:finops/provider/botLVL/InsuranceTypeProvider.dart';
import 'package:finops/provider/botLVL/KeywordTagProvider.dart';
import 'package:finops/provider/botLVL/OperationTypeProvider.dart';
import 'package:finops/provider/botLVL/PaymentApprovalStatusProvider.dart';
import 'package:finops/provider/botLVL/PaymentMethodProvider.dart';
import 'package:finops/provider/botLVL/PaymentStatusProvider.dart';
import 'package:finops/provider/botLVL/PaymentTypeProvider.dart';
import 'package:finops/provider/botLVL/RealEstateTypeProvider.dart';
import 'package:finops/provider/botLVL/TaxTypeProvider.dart';
import 'package:finops/provider/botLVL/UnitMeasureProvider.dart';
import 'package:finops/provider/botLVL/UtilityCalculationTypeProvider.dart';
import 'package:finops/provider/botLVL/UtilityTypeProvider.dart';
import 'package:finops/provider/botLVL/VacationTypeProvider.dart';
import 'package:finops/provider/botLVL/VehicleBrandProvider.dart';
import 'package:finops/provider/botLVL/VehicleModelProvider.dart';
import 'package:finops/provider/botLVL/VehicleRegistrationNumberProvider.dart';
import 'package:finops/provider/botLVL/VehicleYearProvider.dart';
import 'package:finops/screens/homeScreen.dart';
import 'package:finops/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/botLVL/ActivityTypeProvider.dart';
import 'provider/botLVL/BrandTagProvider.dart';
import 'provider/botLVL/MonedaProvider.dart';

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
    ChangeNotifierProvider(create: (context) => TaxTypeProvider()),
    ChangeNotifierProvider(create: (context) => UtilityTypeProvider()),
    ChangeNotifierProvider(create: (context) => DocumentClassProvider()),
    ChangeNotifierProvider(create: (context) => UnitMeasureProvider()),
    ChangeNotifierProvider(create: (context) => PaymentMethodProvider()),
    ChangeNotifierProvider(create: (context) => PaymentTypeProvider()),
    ChangeNotifierProvider(create: (context) => CategoryTagProvider()),
    ChangeNotifierProvider(create: (context) => BrandTagProvider()),
    ChangeNotifierProvider(create: (context) => KeywordTagProvider()),
    ChangeNotifierProvider(create: (context) => ConsumptionLocationProvider()),
    ChangeNotifierProvider(create: (context) => RealEstateTypeProvider()),
    ChangeNotifierProvider(create: (context) => ActivityTypeProvider()),
    ChangeNotifierProvider(create: (context) => UtilityCalculationTypeProvider()),
    ChangeNotifierProvider(create: (context) => IndexReadingTypeProvider()),
    ChangeNotifierProvider(create: (context) => PaymentStatusProvider()),
    ChangeNotifierProvider(create: (context) => PaymentApprovalStatusProvider()),
    ChangeNotifierProvider(create: (context) => VacationTypeProvider()),
    ChangeNotifierProvider(create: (context) => InsuranceTypeProvider()),
    ChangeNotifierProvider(create: (context) => VehicleRegistrationNumberProvider()),
    ChangeNotifierProvider(create: (context) => VehicleBrandProvider()),
    ChangeNotifierProvider(create: (context) => VehicleYearProvider()),
    ChangeNotifierProvider(create: (context) => FuelTypeProvider()),
    ChangeNotifierProvider(create: (context) => VehicleModelProvider()),
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
