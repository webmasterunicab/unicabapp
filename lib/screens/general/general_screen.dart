import 'package:flutter/material.dart';
import '../../models/general/options.dart';
import '../../models/general/news.dart';
import '../../repositories/general/opciones_repository.dart';
import '../../repositories/general/noticias_repository.dart';
import '../../widgets/general/student_topbar.dart';
import '../../widgets/general/option_item.dart';
import '../../widgets/general/news_card.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final OptionsRepository _optionsRepository = OptionsRepository();
  final NewsRepository _newsRepository = NewsRepository();

  List<Options> _options = [];
  List<News> _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Inicializar datos de ejemplo si es necesario
      await _optionsRepository.initializeWithSampleData();
      await _newsRepository.initializeWithSampleData();

      // Cargar datos
      final options = await _optionsRepository.getAllOptions();
      final news = await _newsRepository.getRecentNews(limit: 6);

      setState(() {
        _options = options;
        _news = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Calcular altura del topbar fijo
    final screenHeight = MediaQuery.of(context).size.height;
    final topBarHeight =
        screenHeight * 0.15 + MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          // Contenido scrolleable con padding para evitar superposición
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: topBarHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección de opciones
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _options.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 25),
                      itemBuilder: (context, index) {
                        return OptionItem(option: _options[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Línea separadora
                  Container(
                    height: 1,
                    color: const Color(0xFFF5F5F5),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),

                  const SizedBox(height: 30),

                  // Título fuera del contenedor
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Descubre más',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Sección de noticias
                  Container(
                    color: const Color(
                        0xFFDDDBD7), // Color de fondo del contenedor
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40.0), // Espaciado horizontal
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _news.length,
                      itemBuilder: (context, index) {
                        return NewsCard(news: _news[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // TopBar fijo en la parte superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StudentTopBar(),
          ),
        ],
      ),
    );
  }
}
