import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';

class CardObservador extends StatelessWidget {
  final double? fontSize;

  final String? studentName;
  final bool? readOnly;
  final String type;
  final String dependency;
  final String charge;
  final String date;

  final String cardInfo;
  final double? fieldHeight;

  const CardObservador({
    super.key, 
    required this.dependency, 
    required this.charge, 
    required this.date, 
    required this.cardInfo, 
    required this.type,
    this.studentName, 
    this.readOnly = true, 
    this.fontSize, 
    this.fieldHeight = 90, 
  });

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
                if (studentName != null) 
                  Text(studentName!, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 15.sp, fontWeight: FontWeight.bold)),

                Text(type, style: TextStyle(fontFamily: 'Roboto', fontSize: 14.5.sp, fontWeight: FontWeight.bold)),
                Text(dependency, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 14.5.sp)),
                Text(charge, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 14.5.sp, color: Color.fromRGBO(11, 119, 179, 1))),
                Text(date, style: TextStyle(fontFamily: 'Roboto', fontSize: 12.sp)),
              ],
            ),
          ),
          SizedBox(height: 4),
      
          Container(margin: EdgeInsets.symmetric(horizontal: 33), child: TextArea(
            fieldHeight: fieldHeight, 
            readOnly: readOnly,
            fieldBody: cardInfo,
            fontSize: fontSize,
          )),
        ],
      ),
    );
  }
}