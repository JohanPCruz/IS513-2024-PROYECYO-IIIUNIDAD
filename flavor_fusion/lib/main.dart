
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fusion/axel/login.dart';
import 'package:flavor_fusion/johan/design_page_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_fusion/firebase_options.dart';


void main() async {
  // Inicializa Firebase antes de ejecutar la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se verifica la autenticación
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return HomeScreen2(); // Si hay una sesión iniciada, muestra la pantalla HomeScreen2
          } else {
            return Login(); // Si no hay sesión iniciada, muestra la pantalla de inicio de sesión
          }
        }
      },
    );
  }
}
