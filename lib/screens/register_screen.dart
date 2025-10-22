import 'package:flutter/material.dart';
import 'package:volt_guard_true/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'signin_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Botón de regreso y título
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SigninScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 31),
                    const Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Subtítulo
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Únete a la revolución eléctrica',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 35),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        // Campos de texto
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Color(0xFF666666)),
                            decoration: const InputDecoration(
                              hintText: 'Nombre de usuario',
                              hintStyle: TextStyle(color: Color(0xFF999999)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF666666),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Color(0xFF666666)),
                            decoration: const InputDecoration(
                              hintText: 'Correo electrónico',
                              hintStyle: TextStyle(color: Color(0xFF999999)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF666666),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Color(0xFF666666)),
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: const TextStyle(color: Color(0xFF999999)),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xFF666666),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF666666),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Términos y condiciones
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF666666),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 12,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Al registrarte, aceptas nuestros ',
                                    ),
                                    TextSpan(
                                      text: 'Términos de Servicio',
                                      style: const TextStyle(
                                        color: Color(0xFF1A237E),
                                      ),
                                    ),
                                    const TextSpan(text: ' y '),
                                    TextSpan(
                                      text: 'Política de Privacidad',
                                      style: const TextStyle(
                                        color: Color(0xFF1A237E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Botón de registro
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading
                                    ? null
                                    : () async {
                                      try {
                                        if (_nameController.text.isEmpty ||
                                            _emailController.text.isEmpty ||
                                            _passwordController.text.isEmpty ) {
                                          setState(() {
                                            _errorMessage =
                                                'Por favor, complete todos los campos';
                                          });
                                          return;
                                        }
                  
                                        setState(() {
                                          _isLoading = true;
                                          _errorMessage = null;
                                        });
                  
                                        await AuthService()
                                            .registerWithEmailAndPassword(
                                              email: _emailController.text,
                                              password: _passwordController.text,
                                              context: context,
                                            );
                                      } catch (e) {
                                        setState(() {
                                          _errorMessage = e.toString();
                                          _isLoading = false;
                                        });
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1A237E),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child:
                                _isLoading
                                    ? const CircularProgressIndicator(
                                      color: Color(0xFF1A237E),
                                    )
                                    : const Text(
                                      'Crear Cuenta',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Separador
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Color(0xFF666666))),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'o continúa con',
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: Color(0xFF666666))),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Botón de Google
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false,
                              );
                              final success =
                                  await authProvider.signInWithGoogle();
                              if (success && context.mounted) {
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.google, size: 20),
                            label: const Text(
                              'Registrarse con Google',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF5F5F5),
                              foregroundColor: Color(0xFF666666),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ya tienes una cuenta?',
                              style: TextStyle(color: Color(0xFF666666)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                ' Inicia sesión',
                                style: TextStyle(
                                  color: Color(0xFF1A237E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
