import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shitzu/page/forgot_password_page.dart';
import 'package:shitzu/page/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Shitzu App',
      theme: ThemeData(
        // 1. Establecemos el color principal de la app a morado.
        // Esto afectará a la AppBar y otros elementos.
        primarySwatch: Colors.purple,
        // 2. Establecemos el color de fondo para todas las pantallas (Scaffolds).
        scaffoldBackgroundColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'shitzu App',
          style: GoogleFonts.lobster(
            fontSize: 32, // Aumentamos un poco el tamaño para esta fuente
            color: Colors.white, // Hacemos el texto del título blanco
          ),
        ),
        centerTitle: true, // Centramos el título
        backgroundColor:
            Colors.purple, // Hacemos la AppBar morada explícitamente
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    (Scaffold.of(context).appBarMaxHeight ?? 0),
              ),
              child: IntrinsicHeight(
                child: Padding(
                  // Usamos Padding para añadir espacio a los lados.
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Logo de la aplicación
                      Image.asset('assets/images/logo.png', height: 200),
                      const SizedBox(height: 60),

                      // Campo de texto para el correo electrónico
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Correo Electrónico',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo de texto para la contraseña
                      const TextField(
                        obscureText: true, // Oculta el texto de la contraseña
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Botón para iniciar sesión
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                            50,
                          ), // Ancho completo y altura de 50
                        ),
                        onPressed: () {
                          // Aquí irá la lógica para iniciar sesión
                        },
                        child: const Text('Iniciar Sesión'),
                      ),
                      const SizedBox(height: 20),
                      // Botón para recuperar contraseña
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),

                      // Botón para registrarse
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          '¿No tienes una cuenta? Regístrate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
