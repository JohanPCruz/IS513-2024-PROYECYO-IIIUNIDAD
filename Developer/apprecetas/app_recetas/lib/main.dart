import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pantallas/crea_recetas.dart'; 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreaRecetas(), // Página principal de la aplicación
    );
  }
}
