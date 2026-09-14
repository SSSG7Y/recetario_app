import 'package:flutter/material.dart';
import '../models/receta.dart';

class FormularioReceta extends StatefulWidget {
  const FormularioReceta({super.key});

  @override
  State<FormularioReceta> createState() => _FormularioRecetaState();
}

class _FormularioRecetaState extends State<FormularioReceta> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para los campos del formulario
  String _nombre = '';
  String _categoria = 'Almuerzo';
  int _tiempoMin = 30;
  int _porciones = 4;
  String _dificultad = 'Media';
  String _descripcion = '';

  final List<String> _categorias = ['Desayuno', 'Almuerzo', 'Cena', 'Postre'];
  final List<String> _dificultades = ['Facil', 'Media', 'Dificil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre de la receta'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => _nombre = value!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: _categorias.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) => setState(() => _categoria = value!),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Tiempo (min)'),
                      keyboardType: TextInputType.number,
                      initialValue: '30',
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Ingresa un número válido';
                        }
                        return null;
                      },
                      onSaved: (value) => _tiempoMin = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Porciones'),
                      keyboardType: TextInputType.number,
                      initialValue: '4',
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Ingresa un número válido';
                        }
                        return null;
                      },
                      onSaved: (value) => _porciones = int.parse(value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _dificultad,
                decoration: const InputDecoration(labelText: 'Dificultad'),
                items: _dificultades.map((dif) {
                  return DropdownMenuItem(value: dif, child: Text(dif));
                }).toList(),
                onChanged: (value) => setState(() => _dificultad = value!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa una breve descripción';
                  }
                  return null;
                },
                onSaved: (value) => _descripcion = value!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    // Creamos la nueva receta con colores por defecto
                    final nuevaReceta = Receta(
                      id: DateTime.now().millisecondsSinceEpoch,
                      nombre: _nombre,
                      categoria: _categoria,
                      tiempoMin: _tiempoMin,
                      porciones: _porciones,
                      dificultad: _dificultad,
                      destacada: false,
                      colorInicio: 0xFF0284C7,
                      colorFin: 0xFF0369A1,
                      descripcion: _descripcion,
                    );

                    // Retornamos la receta a la pantalla anterior
                    Navigator.pop(context, nuevaReceta);
                  }
                },
                child: const Text('Guardar Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}