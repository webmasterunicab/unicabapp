import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResultadoFinanciero extends StatelessWidget {
  final bool operationSuccess;
  final String? message;

  const ResultadoFinanciero({super.key, required this.operationSuccess, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 242, 240, 1)
            ),
            child: Icon((operationSuccess) ? Icons.check_circle_rounded : Icons.warning_rounded, color: Color.fromRGBO(41, 39, 36, 1), size: 25)
          ),
          SizedBox(width: 10),
      
          Expanded(
            child: Text(
              (message != null) ? message! : "",
              style: TextStyle(fontSize: 14.sp, fontWeight: (operationSuccess) ? FontWeight.normal : FontWeight.bold),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}