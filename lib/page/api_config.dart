import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      // 10.0.2.2 es la dirección especial para el emulador de Android
      // Si usas un celular físico, cambia esto por la IP de tu PC (ej: 192.168.1.X)
      return 'http://10.0.2.2:3000';
    } else {
      return 'http://localhost:3000';
    }
  }
}
