import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/chat/sender_message_bubble.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [

            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return SenderMessageBubble();
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              // child: const InputMensaje(),
            )

          ],

        ),
      ),
    );
  }
}
