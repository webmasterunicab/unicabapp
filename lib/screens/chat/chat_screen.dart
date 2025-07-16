import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/chat/chat_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final avatar = CircleAvatar(
      backgroundImage: AssetImage('imagen.jpg'),
    );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          padding: const EdgeInsets.all(5.0),
          child: avatar,
        ),
        title: Text('Nombre Usuario'),
        centerTitle: true,
      ),
      body: ChatBody(),
    );
  }
}
