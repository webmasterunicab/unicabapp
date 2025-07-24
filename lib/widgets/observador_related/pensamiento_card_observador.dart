import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';

class PensamientoCardObservador extends StatelessWidget {
  const PensamientoCardObservador({super.key, required this.pensamientoName, required this.teacherName, required this.date});

  final String pensamientoName;
  final String teacherName;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),

      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 33),
      
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pensamientoName, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 15)),
                Text(teacherName, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 12, color: Color.fromRGBO(11, 119, 179, 1))),
                Text(date, style: TextStyle(fontFamily: 'Roboto', fontSize: 8)),
              ],
            ),
          ),
          SizedBox(height: 4),
      
          Container(margin: EdgeInsets.symmetric(horizontal: 33), child: TextArea(fieldHeight: 96, readOnly: true)),
        ],
      ),
    );
  }
}