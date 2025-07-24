import 'package:flutter/material.dart';

class ResultadoObservador extends StatelessWidget {
  const ResultadoObservador({super.key, required this.operationSuccess});

  final bool operationSuccess;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 242, 240, 1)
          ),
          child: Icon((operationSuccess) ? Icons.check_circle_rounded : Icons.warning_rounded, color: Color.fromRGBO(41, 39, 36, 1), size: 25)
        ),
        SizedBox(width: 10,),

        Text("Exitoso", style: TextStyle(fontSize: 10))
      ],
    );
  }
}