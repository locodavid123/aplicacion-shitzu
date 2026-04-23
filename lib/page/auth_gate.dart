import 'package:flutter/material.dart';
import 'package:shitzu/page/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // Sin Firebase, necesitarás un servicio de autenticación personalizado
    // para determinar si el usuario está logueado.
    // Por ahora, siempre mostraremos la página de login.
    // En una aplicación real, aquí verificarías un token almacenado localmente.

    // Ejemplo de cómo podrías verificar un estado de autenticación:
    // bool isLoggedIn = await AuthService.isUserLoggedIn();
    // return isLoggedIn ? const HomePage() : const LoginPage();
    return const LoginPage(); // Por defecto, muestra la página de login
  }
}
