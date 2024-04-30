import 'package:flutter/material.dart';
import 'package:app_recetas/Recursos/campos.dart';

class CreaRecetas extends StatefulWidget {
  const CreaRecetas({super.key});

  @override
  _CreaRecetasState createState() => _CreaRecetasState();
}

class _CreaRecetasState extends State<CreaRecetas> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tiempoCocinadoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _porcionesController = TextEditingController();
  //final TextEditingController _unidadController = TextEditingController();
  final List<TextEditingController> _ingredientesControllers = [];
  final List<TextEditingController> _instruccionesControllers = [];
  String? _unidadTiempoSeleccionada;
  String? _dificultadSeleccionada; 
  String? _categoriaSeleccionada;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Receta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                alignment: Alignment.topCenter,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Logo.PNG'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            
            Padding(
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
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
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
                  ),
                  const SizedBox(height: 17),

                  //Descripcion
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      'Describamos un poco tu receta',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descripcionController,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La Descripcion es obligatoria';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Descripcion de la Receta',
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

                  // Instrucciones
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

                  // Dificultad
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Qué tan difícil será esta receta?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: _dificultadSeleccionada,
                      items: ['Fácil', 'Medio', 'Difícil'].map((String dificultad) {
                        return DropdownMenuItem<String>(
                          value: dificultad,
                          child: Text(dificultad),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dificultadSeleccionada = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Dificultad',
                        prefixIcon: Icon(Icons.star),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Categorías
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Cuál sería la Categoría para esta Receta?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: _categoriaSeleccionada,
                      items: [ 'Acompañamientos', 'Bebidas', 'Entradas o Aperitivos', 'Plato Fuerte', 'Postres', 'Sopas'].map((String categoria) {
                        return DropdownMenuItem<String>(
                          value: categoria,
                          child: Text(categoria),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _categoriaSeleccionada = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Porciones o Personas
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Rendirá para...?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _porcionesController,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Cantidad',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _categoriaSeleccionada == 'Postres' ? 'Porciones' : 'Personas',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tiempo de Preparación
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¿Cuánto tiempo en total nos llevará hacer esta receta?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
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
                            labelText: 'Tiempo Total de Preparación',
                            prefixIcon: Icon(Icons.access_alarm_rounded),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _unidadTiempoSeleccionada,
                          items: ['Segundos', 'Minutos', 'Horas'].map((String unidadTiempo) {
                            return DropdownMenuItem<String>(
                              value: unidadTiempo,
                              child: Text(unidadTiempo),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _unidadTiempoSeleccionada = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Unidad de Tiempo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),


                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      '¡Excelente! Creemos tu Receta.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Boton para Crear la Receta
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                onPressed: () {}, 
                //=> _guardarRecetas(context),
                child: const Text('Guardar Receta'),
              ),
                  ),
                ],
              ),
            ),
          ),
            ],
        ),
      ),
      ),
    );
  }
}
