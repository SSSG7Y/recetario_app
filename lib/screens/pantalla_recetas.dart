import 'package:flutter/material.dart';
import '../models/receta.dart';
import '../data/recetas_semilla.dart';
import 'detalle_receta.dart';

class PantallaRecetas extends StatefulWidget {
  const PantallaRecetas({super.key});

  @override
  State<PantallaRecetas> createState() => _PantallaRecetasState();
}

class _PantallaRecetasState extends State<PantallaRecetas> {
  final List<Receta> _listaRecetas = List.from(recetasSemilla);
  final Set<int> _favoritos = {}; // Almacena los IDs de las recetas favoritas
  bool _soloFavoritos = false;     // Estado del filtro

  @override
  Widget build(BuildContext context) {
    // Filtrar la lista según el estado actual del filtro de favoritos
    final recetasMostradas = _soloFavoritos
        ? _listaRecetas.where((r) => _favoritos.contains(r.id)).toList()
        : _listaRecetas;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recetario (${_favoritos.length} favs)'),
        actions: [
          // Botón en la AppBar para alternar entre todas y solo favoritas
          IconButton(
            icon: Icon(
              _soloFavoritos ? Icons.favorite : Icons.favorite_border,
              color: _soloFavoritos ? Colors.red : null,
            ),
            tooltip: _soloFavoritos ? 'Mostrar todas' : 'Ver solo favoritas',
            onPressed: () {
              setState(() {
                _soloFavoritos = !_soloFavoritos;
              });
            },
          ),
        ],
      ),
      body: recetasMostradas.isEmpty
          ? const Center(
              child: Text(
                'No hay recetas favoritas guardadas',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: recetasMostradas.length,
              itemBuilder: (context, index) {
                final receta = recetasMostradas[index];
                final esFavorito = _favoritos.contains(receta.id);

                return Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: receta.destacada
                        ? const BorderSide(color: Colors.amber, width: 2)
                        : BorderSide.none,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleReceta(receta: receta),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(receta.colorInicio), Color(receta.colorFin)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (receta.destacada)
                                  const Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Icon(Icons.star, color: Colors.amber, size: 20),
                                  ),
                                // Botón de favorito individual dentro de cada tarjeta
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: IconButton(
                                    icon: Icon(
                                      esFavorito ? Icons.favorite : Icons.favorite_border,
                                      color: esFavorito ? Colors.red : Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (esFavorito) {
                                          _favoritos.remove(receta.id);
                                        } else {
                                          _favoritos.add(receta.id);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      receta.nombre,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        shadows: [Shadow(blurRadius: 3, color: Colors.black45)],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Chip(
                                  label: Text(receta.categoria, style: const TextStyle(fontSize: 10)),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${receta.tiempoMin} min', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    Text('${receta.porciones} porc.', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}