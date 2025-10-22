import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Estado del usuario actual
  Stream<User?> get user => FirebaseAuth.instance.authStateChanges();

  // Registro con email y contraseña
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verificar si el contexto sigue montado antes de usar Navigator
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home_new');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'La contraseña proporcionada es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        throw 'Ya existe una cuenta con ese correo electrónico';
      }
      throw e.message ?? 'Error en el registro';
    }
  }

  // Inicio de sesión con email y contraseña
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verificar si el contexto sigue montado antes de usar Navigator
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home_new');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No existe un usuario con ese correo electrónico';
      } else if (e.code == 'wrong-password') {
        throw 'Contraseña incorrecta';
      } else if (e.code == 'invalid-email') {
        throw 'El formato del correo electrónico no es válido';
      } else if (e.code == 'user-disabled') {
        throw 'Este usuario ha sido deshabilitado';
      } else {
        throw 'Error al iniciar sesión: ${e.message}';
      }
    } catch (e) {
      throw 'Error al iniciar sesión: $e';
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Verificar si el usuario está autenticado
  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Obtener usuario actual
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
