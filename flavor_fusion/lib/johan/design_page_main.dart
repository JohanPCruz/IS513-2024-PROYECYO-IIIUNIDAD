import 'package:flavor_fusion/carlos/Pantallas/crea_recetas.dart';
import 'package:flutter/material.dart';

//Pantalla de muestra de diseno de pantalla de app de recetas

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
            const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreaRecetas()),
                  );
                },
                child: const Text('¡A Crear una Nueva Receta!'),
              ),

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
            backgroundColor: Colors.blue, 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            backgroundColor: Colors.red, 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}