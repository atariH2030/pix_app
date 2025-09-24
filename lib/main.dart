import 'package:flutter/material.dart';
// AQUI ESTÁ A CORREÇÃO (sem o 'lib/')
import 'package:pix_app/screens/pix_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.teal;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PIX App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const PixHomeScreen(),
    );
  }
}
