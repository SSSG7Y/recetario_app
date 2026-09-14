class Receta {
  final int id;
  final String nombre;
  final String categoria;
  final int tiempoMin;
  final int porciones;
  final String dificultad; // 'Facil' | 'Media' | 'Dificil'
  final bool destacada;
  final int colorInicio; // hex para el degradado
  final int colorFin;    // hex para el degradado
  final String descripcion;

  Receta({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.tiempoMin,
    required this.porciones,
    required this.dificultad,
    required this.destacada,
    required this.colorInicio,
    required this.colorFin,
    required this.descripcion,
  });
}