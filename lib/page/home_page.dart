import 'package:flutter/material.dart';
import 'package:shitzu/page/login_page.dart';

class HomePage extends StatelessWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Aquí deberías implementar la lógica de cerrar sesión:
              // 1. Eliminar cualquier token de autenticación almacenado localmente.
              // 2. Notificar a tu servicio de autenticación personalizado.
              // 3. Navegar de vuelta a la pantalla de login.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¡Bienvenido!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(
              email, // Mostrar el email real pasado desde el Login
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
