import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hopepaw/features/providers/language_provider.dart';
import 'package:hopepaw/features/splash/UI/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/providers/user_provider.dart';
import 'firebase_options.dart';

// ...

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://pdivyxrgnnuzdihrhdgy.supabase.co', 
    anonKey: 'sb_publishable_U2tyYaGMsCXxr9jasx5_cQ_GDg35uLF', 
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserData()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hope Paw',
            locale: languageProvider.locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B61FF)),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}


