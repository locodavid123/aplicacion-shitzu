import 'package:flutter/material.dart';

/// HomePage actúa como un controlador de acceso que, basándose en el rol recibido,
/// muestra la interfaz adecuada para el usuario (admin, root o cliente).
class HomePage extends StatelessWidget {
  final String email;
  final String role;

  const HomePage({super.key, required this.email, required this.role});

  @override
  Widget build(BuildContext context) {
    // Evaluamos el rol para decidir qué vista cargar.
    // Esto evita la necesidad de hacer un segundo Navigator.push, mejorando el UX.
    switch (role.toLowerCase()) {
      case 'admin':
        return _AdminDashboard(email: email);
      case 'root':
        return _RootDashboard(email: email);
      case 'cliente':
      default:
        return _ClienteDashboard(email: email);
    }
  }
}

/// Interfaz para el rol 'admin'
class _AdminDashboard extends StatelessWidget {
  final String email;
  const _AdminDashboard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administrador'),
        actions: [_logoutAction(context)],
      ),
      body: Center(child: Text('Sesión iniciada como Admin: $email')),
    );
  }
}

/// Interfaz para el rol 'cliente'
class _ClienteDashboard extends StatelessWidget {
  final String email;
  const _ClienteDashboard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta - Cliente'),
        actions: [_logoutAction(context)],
      ),
      body: Center(child: Text('Bienvenido Cliente: $email')),
    );
  }
}

/// Interfaz para el rol 'root'
class _RootDashboard extends StatelessWidget {
  final String email;
  const _RootDashboard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Maestro (Root)'),
        actions: [_logoutAction(context)],
      ),
      body: Center(child: Text('Acceso total para: $email')),
    );
  }
}

/// Acción común de cerrar sesión
Widget _logoutAction(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.logout),
    onPressed: () {
      // Redirige al login. Nota: Asegúrate de tener definida la ruta '/login' en tu MaterialApp
      Navigator.of(context).pushReplacementNamed('/login');
    },
  );
}
