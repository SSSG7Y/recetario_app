import 'package:flutter/material.dart';
import 'screens/pantalla_recetas.dart';

void main() => runApp(const RecetarioApp());

class RecetarioApp extends StatelessWidget {
  const RecetarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetario',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0891B2),
        useMaterial3: true,
      ),
      home: const PantallaRecetas(),
    );
  }
}