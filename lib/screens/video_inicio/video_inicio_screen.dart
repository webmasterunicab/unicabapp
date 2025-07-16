import 'package:flutter/material.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';
import 'package:uniconecta/screens/registro_estudiante/registro_screen.dart';
import 'package:video_player/video_player.dart';

class VideoInicioScreen extends StatefulWidget {
  const VideoInicioScreen({super.key});

  @override
  State<VideoInicioScreen> createState() => _VideoInicioScreenState();
}

class _VideoInicioScreenState extends State<VideoInicioScreen> {
  late VideoPlayerController controller;

@override
void initState() {
  super.initState();
  _setupVideo();
}

Future<void> _setupVideo() async {
  controller = VideoPlayerController.asset('assets/video/inicio.mp4');
  await controller.initialize();
  controller.setVolume(0);
  controller.play();

  controller.addListener(() {
    if (controller.value.position >= controller.value.duration &&
        !controller.value.isPlaying) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => InicioScreen()),
      );
    }
  });

  setState(() {}); // Renderiza el primer frame
}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VideoPlayer(controller),
    );
  }
}
