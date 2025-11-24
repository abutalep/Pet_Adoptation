import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class HopePawApp extends StatelessWidget {
  const HopePawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "HopePaw",
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
