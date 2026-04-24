import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shitzu/page/api_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String apiUrl = '${ApiConfig.baseUrl}/api/users';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': _fullNameController.text.trim(),
          'username': _usernameController.text.trim(),
          'country': _countryController.text.trim(),
          'city': _cityController.text.trim(),
          'phone': _phoneController.text.trim(),
          'age': int.tryParse(_ageController.text.trim()) ?? 0,
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Usuario registrado y sincronizado con éxito!'),
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error al registrarse: ${jsonDecode(response.body)['error'] ?? response.body}',
            ),
            backgroundColor: Colors.red,
          ),
        );
        // No navegar si la sincronización con el servidor falla
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de conexión: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrió un error inesperado.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro', style: GoogleFonts.lobster(fontSize: 32)),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 40),
                        Image.asset('assets/images/logo.png', height: 150),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Nombre Completo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingresa tu nombre'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Nombre de Usuario',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingresa un usuario'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _countryController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: 'País',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Requerido'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  labelText: 'Ciudad',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Requerido'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Teléfono',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingresa tu teléfono'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Edad',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.cake),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa tu edad';
                            }
                            final age = int.tryParse(value);
                            if (age == null) return 'Ingresa un número válido';
                            if (age < 18) {
                              return 'Debes ser mayor de 18 años para registrarte';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Correo Electrónico',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, ingresa un correo.';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value.trim())) {
                              return 'Por favor, ingresa un correo válido.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, ingresa una contraseña.';
                            }
                            if (value.trim().length < 6) {
                              return 'La contraseña debe tener al menos 6 caracteres.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Confirmar Contraseña',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, confirma tu contraseña.';
                            }
                            if (value.trim() !=
                                _passwordController.text.trim()) {
                              return 'Las contraseñas no coinciden.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: _isLoading ? null : _register,
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : const Text('Registrarse'),
                        ),
                      ],
                    ),
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
