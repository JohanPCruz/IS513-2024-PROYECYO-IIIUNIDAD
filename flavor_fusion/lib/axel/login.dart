import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Método para iniciar sesión con Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión exitoso"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión con Google cancelado."),
            duration: Duration(seconds: 2),
          ),
        );
      }
      // Navegar a la siguiente pantalla o realizar acciones adicionales después del inicio de sesión exitoso.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error de inicio de sesión: $e"),
          duration: Duration(seconds: 2),
        ),
      );
      // Manejar errores de inicio de sesión, como credenciales incorrectas o cuenta no existente.
    }
  }

  // Método para cerrar sesión
  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut(); // Opcional: cerrar sesión de Google también
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sesión cerrada exitosamente"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al cerrar sesión: $e"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: Text('Iniciar sesión con Google'),
            ),
            ElevatedButton(
              onPressed: () => _signOut(context), // Llamar al método _signOut
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}