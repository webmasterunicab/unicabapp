import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/chat/emisor_message_bubble.dart';
import 'package:uniconecta/widgets/chat/receptor_message_bubble.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return (index % 2 ==  0) ? EmisorMessageBubble() : ReceptorMessageBubble();
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
