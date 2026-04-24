import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    const String envBaseUrl = String.fromEnvironment('API_BASE_URL');
    if (envBaseUrl.isNotEmpty) {
      return envBaseUrl;
    }

    if (kIsWeb) {
      debugPrint('🌐 API Config: Modo Web');
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      debugPrint('🤖 API Config: Modo Android (Emulador)');
      // IMPORTANTE: 10.0.2.2 es para el emulador.
      // Si usas un celular físico, cambia esto por la IP de tu PC (ej. 192.168.1.15)
      return 'http://10.0.2.2:3000';
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      debugPrint('💻 API Config: Modo Desktop');
      return 'http://127.0.0.1:3000';
    } else {
      return 'http://10.0.2.2:3000';
    }
  }
}
