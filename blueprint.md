
# Blueprint: Christian Library App

## Visión General

Esta aplicación es una "Biblioteca Cristiana" diseñada para que los usuarios exploren y descubran libros cristianos. La interfaz de usuario es moderna, visualmente atractiva y sigue las pautas de diseño de Apple, con un fondo oscuro, texto claro y elementos de interfaz de usuario translúcidos.

## Características Implementadas

*   **Pantalla de Búsqueda**: La pantalla principal de la aplicación, que permite a los usuarios buscar libros.
*   **Libros Destacados**: Una sección que muestra una selección curada de libros.
*   **Lista de Libros**: Una lista de libros recomendados para el crecimiento espiritual del usuario.
*   **Estilo Moderno**: La aplicación utiliza un tema oscuro, fuentes personalizadas y efectos de desenfoque para una apariencia y sensación premium.

## Plan de Refactorización

1.  **Introducir un Modelo de Libro**: Crear una clase `Book` para representar los datos del libro de una manera más estructurada.
2.  **Abstraer los Datos del Libro**: Mover los datos del libro a una clase separada `BookData` para simular un repositorio de datos.
3.  **Dividir los Widgets de la Interfaz de Usuario**:
    *   `SearchBarWidget`: Un widget para la funcionalidad de búsqueda.
    *   `FeaturedBooksWidget`: Un widget para mostrar la cuadrícula de libros destacados.
    *   `BookListWidget`: Un widget para mostrar la lista vertical de libros.
    *   `BottomNavBar`: Un widget para la barra de navegación inferior.
4.  **Refinar el Tema**: Mejorar el `ThemeData` para una mayor consistencia y reutilización de estilos.
5.  **Limpiar `main.dart`**: Reestructurar el archivo `lib/main.dart` para usar los nuevos widgets y la estructura de datos.
