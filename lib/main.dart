import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/config/router/app_router.dart';
import 'package:cine_app/config/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async{
  await dotenv.load(fileName: ".env");
   Hive.initFlutter();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      //Body is not needed, because go router(is a initialLocation '/' on app router)
    );
  }
}