
import 'package:flavor_fusion/johan/design_page_main.dart';
import 'package:flavor_fusion/johan/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_fusion/firebase_options.dart';


void main() async {
  // Inicializa Firebase antes de ejecutar la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App Recetas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), //aqui debe de ir la pagina de inicio de sesion para que sea la primera que salga al abrir el app la primera vez
    );
  }
}

//Recomendaria no colocar mas informacion en el manin.dart con esto es suficiente