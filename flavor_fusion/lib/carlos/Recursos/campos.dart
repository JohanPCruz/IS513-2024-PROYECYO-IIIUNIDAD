import 'package:flutter/material.dart';

class EditorCamposIngredientes extends StatefulWidget {
  final List<TextEditingController> ingredientesControllers;

  const EditorCamposIngredientes({
    super.key,
    required this.ingredientesControllers,
  });

  @override
  _EditorCamposIngredientesState createState() => _EditorCamposIngredientesState();
}

class _EditorCamposIngredientesState extends State<EditorCamposIngredientes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.ingredientesControllers.add(TextEditingController());
            });
          },
          child: const Text('Agregar Ingrediente'),
        ),
        const SizedBox(height: 20),

        // Mostrar la lista de TextFields para los ingredientes
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.ingredientesControllers.length,
          itemBuilder: (context, index) {

            // Obtener el número de orden sumando 1 al índice
            int orden = index + 1;

            // Paquete de Material llamado Dismissible
            // Sirve para deslizar y eliminar un elemento seleccionado
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.ingredientesControllers.removeAt(index);
                });
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    // Mostrar el número de orden
                    Text('$orden. '),

                    // El TextFormField para el ingrediente
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por Favor, Ingrese los Ingredientes';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: widget.ingredientesControllers[index],
                        decoration: const InputDecoration(
                          labelText: 'Ingredientes',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.receipt_long_rounded),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        ),
                        maxLines: null, // Permitir múltiples líneas
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class EditorCamposInstrucciones extends StatefulWidget {
  final List<TextEditingController> instruccionesControllers;

  const EditorCamposInstrucciones({
    super.key,
    required this.instruccionesControllers,
  });

  @override
  _EditorCamposInstruccionesState createState() => _EditorCamposInstruccionesState();
}

class _EditorCamposInstruccionesState extends State<EditorCamposInstrucciones> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.instruccionesControllers.add(TextEditingController());
            });
          },
          child: const Text('Agregar Instrucción'),
        ),
        const SizedBox(height: 20),

        // Mostrar la lista de TextFields para las instrucciones
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.instruccionesControllers.length,
          itemBuilder: (context, index) {

            // Obtener el número de orden sumando 1 al índice
            int orden = index + 1;

            // Paquete de Material llamado Dismissible
            // Sirve para deslizar y eliminar un elemento seleccionado
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.instruccionesControllers.removeAt(index);
                });
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    // Mostrar el número de orden
                    Text('$orden. '),

                    // El TextFormField para la instrucción
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por Favor, Ingrese los Pasos a Seguir';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: widget.instruccionesControllers[index],
                        decoration: const InputDecoration(
                          labelText: 'Instrucciones',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.info_outline),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        ),
                        maxLines: null, // Permitir múltiples líneas
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}