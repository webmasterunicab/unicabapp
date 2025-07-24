import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  const TextArea({super.key, this.fieldHeight, this.readOnly = false});

  final double? fieldHeight; 
  final bool? readOnly;

  @override
  State<TextArea> createState() => _TextFieldObservadorState();
}

class _TextFieldObservadorState extends State<TextArea> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 242, 240, 1),
        boxShadow: [
          BoxShadow(blurRadius: 6, offset: Offset(0, 3), color: Color.fromRGBO(0, 0, 0, 0.16))
        ]
      ),
      child: SizedBox(
        height: widget.fieldHeight,
        child: TextField(
          readOnly: widget.readOnly!,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          controller: controller,
          style: TextStyle(
            fontFamily: 'Roboto'
          ),
        
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        
        ),
      ),
    );
  }
}