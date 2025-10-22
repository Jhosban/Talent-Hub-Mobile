import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/google_auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  User? _user;
  String? _errorMessage;
  final bool _isLoading = false;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Escuchar cambios en el estado de autenticación
    _authService.user.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // // Registrar usuario
  // Future<bool> register(String email, String password) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   // notifyListeners();

  //   try {
  //     await _authService.registerWithEmailAndPassword(email, password);
  //     _isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  // Iniciar sesión
  // Future<bool> signIn(String email, String password) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     final userCredential = await _authService.signInWithEmailAndPassword(email, password);
  //     _isLoading = false;
  //     notifyListeners();
  //     // Verificar si el usuario se autenticó correctamente
  //     return userCredential.user != null;
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  // Iniciar sesión con Google
  Future<bool> signInWithGoogle() async {
    try {
      final userCredential = await _googleAuthService.signInWithGoogle();
      return userCredential != null;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    if (_user != null) {
      if (_user!.providerData.any(
        (element) => element.providerId == 'google.com',
      )) {
        await _googleAuthService.signOut();
      } else {
        await _authService.signOut();
      }
    }
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
