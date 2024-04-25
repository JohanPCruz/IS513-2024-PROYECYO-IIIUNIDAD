import 'package:flutter/material.dart';
import 'package:app_recetas/API/recurso_api.dart';

class Recetas extends StatefulWidget {
  @override
  _RecetasState createState() => _RecetasState();
}

class _RecetasState extends State<Recetas> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _instruccionesController = TextEditingController();
  final TextEditingController _tiempoCocinadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre de la Receta'),
            ),
            
            TextFormField(
              controller: _ingredientesController,
              decoration: const InputDecoration(labelText: 'Ingredientes'),
              maxLines: null,
            ),

            TextFormField(
              controller: _instruccionesController,
              decoration: const InputDecoration(labelText: 'Instrucciones'),
              maxLines: null,
            ),

            TextFormField(
              controller: _tiempoCocinadoController,
              decoration: const InputDecoration(labelText: 'Tiempo de Cocinado'),
              keyboardType: TextInputType.number,
            ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRecipe,
              child: const Text('Enviar Receta'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRecipe() {
    ApiService.submitRecipe(
      apiKey: 'vHwuVEqAGqUnErEHjK1XZ1iuFMujZU8w', 
      title: _nameController.text,
      ingredients: _ingredientesController.text,
      instructions: _instruccionesController.text,
      cookingTime: int.tryParse(_tiempoCocinadoController.text) ?? 0,
    );
  }
}


