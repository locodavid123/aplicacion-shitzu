import 'package:flutter/material.dart';
import 'package:shitzu/page/auth_gate.dart';
import 'package:shitzu/page/login_page.dart';

// Esta es la ÚNICA función main que debe existir.
void main() async {
  // Asegura que los bindings de Flutter estén inicializados antes de cualquier otra cosa.
  WidgetsFlutterBinding.ensureInitialized();

  // Ejecuta la aplicación.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Shitzu App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 203, 65, 227),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthGate(),
      routes: {'/login': (context) => const LoginPage()},
    );
  }
}
