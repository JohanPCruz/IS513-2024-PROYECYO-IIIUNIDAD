import 'package:flutter/material.dart';
import 'package:app_recetas/Recursos/campos.dart';
//import 'package:app_recetas/API/recurso_api.dart'; 

class CreaRecetas extends StatefulWidget {
  @override
  _CreaRecetasState createState() => _CreaRecetasState();
}

class _CreaRecetasState extends State<CreaRecetas> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _instruccionesController = TextEditingController();
  final TextEditingController _tiempoCocinadoController = TextEditingController();
  final List<TextEditingController> _ingredientesControllers = [];
  final List<TextEditingController> _instruccionesControllers = [];

//  final List<String> _sugerenciasIngredientes = []; // Lista de sugerencias de ingredientes
//  final TextEditingController _ingredientesAutocompletadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Receta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/Logo.PNG'),
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Cómo le pondrás a tu receta?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la Receta',
                      prefixIcon: Icon(Icons.abc),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 17),


                  // Ingredientes
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Cuáles serán los Ingredientes a utilizar?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: EditorCamposIngredientes(
                          ingredientesControllers: _ingredientesControllers,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),

                  //Instrucciones
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Y los Pasos a seguir serán...?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: EditorCamposInstrucciones(
                          instruccionesControllers: _instruccionesControllers,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),

                  //Tiempo de Preparacion
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Cuánto tiempo llevará hacer esta receta?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _tiempoCocinadoController,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor, Ingrese el Tiempo de Preparación';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Tiempo de Preparación',
                      prefixIcon: Icon(Icons.access_alarm_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 17),

                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¡Excelente! Creemos tu Receta.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Boton para Crear la Receta
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Crear Receta'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}