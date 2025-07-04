import 'package:flutter/material.dart';
import '../../models/general/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showNewsDetail(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen real de la noticia con espaciado
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    news.foto,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback al gradiente original si no se encuentra la imagen
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getColorByCategory(news.titulo),
                              _getColorByCategory(news.titulo)
                                  .withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            _getIconByCategory(news.titulo),
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Solo título
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                news.titulo,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(
                      0xFF64605C), // Color hexadecimal #64605C sin transparencia
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewsDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            news.titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  news.texto,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    news.descripcion,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Color _getColorByCategory(String titulo) {
    final lowerTitle = titulo.toLowerCase();
    if (lowerTitle.contains('semestre') || lowerTitle.contains('académico')) {
      return Colors.blue;
    } else if (lowerTitle.contains('biblioteca') ||
        lowerTitle.contains('digital')) {
      return Colors.green;
    } else if (lowerTitle.contains('competencia') ||
        lowerTitle.contains('programación')) {
      return Colors.orange;
    } else if (lowerTitle.contains('beca') ||
        lowerTitle.contains('excelencia')) {
      return Colors.purple;
    } else if (lowerTitle.contains('cultural') ||
        lowerTitle.contains('evento')) {
      return Colors.pink;
    } else if (lowerTitle.contains('mantenimiento') ||
        lowerTitle.contains('campus')) {
      return Colors.red;
    } else {
      return Colors.indigo;
    }
  }

  IconData _getIconByCategory(String titulo) {
    final lowerTitle = titulo.toLowerCase();
    if (lowerTitle.contains('semestre') || lowerTitle.contains('académico')) {
      return Icons.school;
    } else if (lowerTitle.contains('biblioteca') ||
        lowerTitle.contains('digital')) {
      return Icons.library_books;
    } else if (lowerTitle.contains('competencia') ||
        lowerTitle.contains('programación')) {
      return Icons.code;
    } else if (lowerTitle.contains('beca') ||
        lowerTitle.contains('excelencia')) {
      return Icons.star;
    } else if (lowerTitle.contains('cultural') ||
        lowerTitle.contains('evento')) {
      return Icons.event;
    } else if (lowerTitle.contains('mantenimiento') ||
        lowerTitle.contains('campus')) {
      return Icons.build;
    } else {
      return Icons.article;
    }
  }
}
