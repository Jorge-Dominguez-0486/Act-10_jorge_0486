import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

void main() {
  runApp(const ChristianLibraryApp());
}

// Clase de modelo para representar un libro
class Book {
  final String title;
  final String author;
  final String image;
  final String? price;

  const Book({
    required this.title,
    required this.author,
    required this.image,
    this.price,
  });
}

// Datos simulados de la aplicación (URLs actualizadas para que funcionen)
class BookData {
  static final List<Book> featuredBooks = [
    const Book(
      title: "Parábolas",
      author: "John MacArthur",
      // Usamos una imagen genérica de libro religioso que sí carga
      image: "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=1000", 
    ),
    const Book(
      title: "¿Vives la Biblia?",
      author: "Miguel Núñez",
      image: "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=1000",
    ),
  ];

  static final List<Book> listBooks = [
    const Book(
      title: "The Field of Boaz",
      author: "Cynthia Heald",
      price: "\$299.00",
      image: "https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&q=80&w=1000",
    ),
    const Book(
      title: "El Progreso del Peregrino",
      author: "John Bunyan",
      price: "\$150.00",
      image: "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=1000",
    ),
    const Book(
      title: "Mere Christianity",
      author: "C.S. Lewis",
      price: "\$220.00",
      image: "https://images.unsplash.com/photo-1629198688000-71f23e745b6e?auto=format&fit=crop&q=80&w=1000",
    ),
  ];
}

class ChristianLibraryApp extends StatelessWidget {
  const ChristianLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Cristiana',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(0xFF2C2C2E),
        ),
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Quitamos el bottomNavigationBar fijo para usar el Stack
      body: Stack(
        children: [
          // 1. EL CONTENIDO DE LA APP (FONDO)
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Buscar',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Destacados del mes',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const FeaturedBooksWidget(),
                    const SizedBox(height: 40),
                    Text(
                      'Para tu crecimiento',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const BookListWidget(),
                    const SizedBox(height: 120), // Espacio extra grande al final para que la barra flotante no tape contenido
                  ],
                ),
              ),
            ),
          ),

          // 2. LA BARRA FLOTANTE ESTILO APPLE
          const Positioned(
            bottom: 30, // Separación del fondo
            left: 20,
            right: 20,
            child: AppleFloatingBar(),
          ),
        ],
      ),
    );
  }
}

// WIDGET NUEVO: La barra flotante exacta como la pediste
class AppleFloatingBar extends StatelessWidget {
  const AppleFloatingBar({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 250,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E).withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuItem(Icons.book, "Mis Libros"),
            _buildMenuItem(Icons.shopping_bag, "Tienda"),
            _buildMenuItem(Icons.favorite, "Favoritos"),
            _buildMenuItem(Icons.settings, "Configuración"),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {}, // Aquí iría la navegación
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Altura de la barra flotante
      child: Row(
        children: [
          // BOTÓN DE CÍRCULO (MENÚ)
          GestureDetector(
            onTap: () => _showMenu(context),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2E), // Gris oscuro
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home_filled, color: Colors.white, size: 24),
            ),
          ),
          
          const SizedBox(width: 10), // Espacio entre botón y buscador

          // BARRA DE BÚSQUEDA (ESTILO CÁPSULA)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), // Bordes muy redondos
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: const Color(0xFF2C2C2E).withOpacity(0.8), // Semi-transparente
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Apple Books', // Texto como en la imagen
                          style: GoogleFonts.inter(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Icon(Icons.mic, color: Colors.grey, size: 22),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGETS ANTERIORES (Ligeramente ajustados para las imágenes) ---

class FeaturedBooksWidget extends StatelessWidget {
  const FeaturedBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: BookData.featuredBooks.map((book) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(book.image),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.author,
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class BookListWidget extends StatelessWidget {
  const BookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: BookData.listBooks.length,
      itemBuilder: (context, index) {
        final book = BookData.listBooks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(book.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            border: Border.all(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            book.price!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}