import 'package:flutter/material.dart';

// Importa aquí tus diferentes páginas
import 'package:flavor_fusion/axel/Comentarios.dart';
import 'package:flavor_fusion/axel/login.dart';
import 'package:flavor_fusion/johan/main_page.dart';
import 'package:flavor_fusion/carlos/Pantallas/crea_recetas.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int _selectedIndex = 0; // Índice inicial seleccionado en el BottomNavigationBar

  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const CreaRecetas(),
    const Comentarios(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flavor Fusion!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: Navigator(
        pages: [
          MaterialPage(child: _pages[_selectedIndex]),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {
            _selectedIndex = 0;
          });
          return true;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange, // Color de ítem seleccionado
        unselectedItemColor: Colors.grey, // Color de ítem no seleccionado
        currentIndex: _selectedIndex, // Índice actualmente seleccionado
        onTap: (int index) {
          setState(() {
            _selectedIndex = index; // Actualiza el índice al hacer tap
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Crear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Comentarios',
          ),
        ],
      ),
    );
  }
}
