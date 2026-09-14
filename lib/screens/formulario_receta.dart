import 'package:flutter/material.dart';
import '../models/receta.dart';

class FormularioReceta extends StatefulWidget {
  const FormularioReceta({super.key});

  @override
  State<FormularioReceta> createState() => _FormularioRecetaState();
}

class _FormularioRecetaState extends State<FormularioReceta> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tiempoController = TextEditingController();
  final _porcionesController = TextEditingController();
  final _descripcionController = TextEditingController();
  
  String _categoriaSeleccionada = 'Almuerzo';
  String _dificultadSeleccionada = 'Media';

  final List<String> _categorias = ['Desayuno', 'Almuerzo', 'Cena', 'Postre', 'Bebida'];
  final List<String> _dificultades = ['Facil', 'Media', 'Dificil'];

  @override
  void dispose() {
    _nombreController.dispose();
    _tiempoController.dispose();
    _porcionesController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardarReceta() {
    if (_formKey.currentState!.validate()) {
      final nuevaReceta = Receta(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: _nombreController.text.trim(),
        categoria: _categoriaSeleccionada,
        tiempoMin: int.parse(_tiempoController.text.trim()),
        porciones: int.parse(_porcionesController.text.trim()),
        dificultad: _dificultadSeleccionada,
        destacada: false,
        colorInicio: 0xFF3B82F6, // Color predeterminado para nuevas recetas
        colorFin: 0xFF1D4ED8,
        descripcion: _descripcionController.text.trim(),
      );

      Navigator.pop(context, nuevaReceta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Receta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la receta', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Ingrese un nombre obligatorio' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(labelText: 'Categoría', border: OutlineInputBorder()),
                items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() => _categoriaSeleccionada = val!),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tiempoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Tiempo (min)', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Requerido';
                        final n = int.tryParse(val);
                        if (n == null || n <= 0) return 'Número > 0';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _porcionesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Porciones', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Requerido';
                        final n = int.tryParse(val);
                        if (n == null || n <= 0) return 'Número > 0';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _dificultadSeleccionada,
                decoration: const InputDecoration(labelText: 'Dificultad', border: OutlineInputBorder()),
                items: _dificultades.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) => setState(() => _dificultadSeleccionada = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descripción', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Ingrese una descripción' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarReceta,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: const Text('Guardar Receta', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}