import 'package:flutter/material.dart';

class ComunidadMegustaBoton extends StatefulWidget {
  final String likeCount;
  final bool dioMeGusta;
  final Future<bool> Function(bool isLiked) onLikeToggle;

  const ComunidadMegustaBoton({
    super.key,
    required this.likeCount,
    required this.onLikeToggle,
    required this.dioMeGusta,
  });

  @override
  State<ComunidadMegustaBoton> createState() => _ComunidadMegustaBotonState();
}

class _ComunidadMegustaBotonState extends State<ComunidadMegustaBoton> {
  late int currentLikes;
  late bool isLiked = false;
  bool isLoading = false; // evita spam de clicks

  @override
  void initState() {
    super.initState();
    currentLikes = int.tryParse(widget.likeCount) ?? 0;
    isLiked = widget.dioMeGusta;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            size: 28,
            color: isLiked ? Colors.red : Colors.black,
          ),
          onPressed: isLoading ? null : _toggleLike,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // fondo blanco
            border: Border.all(
              color: Colors.orange, // borde naranja
              width: 2,
            ),
          ),
          child: Text(
            "$currentLikes",
            style: const TextStyle(
              color: Colors.black, // número negro
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'
            ),
          ),
        ),
      ],
    );
  }

  void _toggleLike() async {
    setState(() {
      isLoading = true;
      // actualizar visualmente de inmediato
      if (isLiked) {
        currentLikes--;
      } else {
        currentLikes++;
      }
      isLiked = !isLiked;
    });

    // llamar a la API
    bool success = await widget.onLikeToggle(isLiked);

    if (!success) {
      setState(() {
        if (isLiked) {
          currentLikes++;
        } else {
          currentLikes--;
        }
        isLiked = !isLiked;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
