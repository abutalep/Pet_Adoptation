import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hopepaw/features/navigation/UI/screens/navigationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hopepaw/features/report/Data/firebase/l10n/app_localizations.dart';
import 'firebase_options.dart';

// ...

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
      home: const NavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


