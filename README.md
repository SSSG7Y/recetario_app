# Examen Práctico - Primer Parcial: App Recetario
**Asignatura:** INF662 Desarrollo de Aplicaciones Móviles  
**Estudiante:** Saulo Sergio Segura Garnica  

## Descripción del Proyecto
Aplicación móvil en Flutter 3.x utilizando **Material 3** y gestión de estado local puramente con `setState` y listas en memoria, cumpliendo estrictamente con las restricciones de no utilizar bases de datos ni gestores externos como Provider[cite: 1].

## Tareas Implementadas
1. **Modelo y Datos Semilla:** Estructura modular en `models/` y `data/` utilizando exclusivamente la estructura `Receta` y `recetasSemilla` provista[cite: 1].
2. **Cuadrícula Principal:** Visualización en `GridView.builder` de 2 columnas con tarjetas estilizadas, degradados dinámicos con `colorInicio` y `colorFin`, y distinción visual para recetas `destacada == true`[cite: 1].
3. **Navegación al Detalle:** Paso del objeto `Receta` mediante constructor hacia `DetalleReceta` con badges condicionales de dificultad (Fácil, Media, Difícil)[cite: 1].
4. **Interactividad con setState:** Sistema de favoritos mediante `Set<int>` con contador en vivo en la `AppBar` y filtro reactivo para alternar entre todas o solo las favoritas[cite: 1].
5. **Formulario y CRUD en Memoria:** Registro de nuevas recetas mediante `FormularioReceta` con validaciones de campos (`GlobalKey<FormState>`), selector de categoría con `DropdownButtonFormField`, y opción de eliminar elementos con confirmación mediante `SnackBar`[cite: 1].

## Cómo Ejecutar el Proyecto
1. Clona el repositorio.
2. Ejecuta `flutter pub get` para asegurar las dependencias.
3. Conecta un emulador o dispositivo físico y ejecuta:
   ```bash
   flutter run