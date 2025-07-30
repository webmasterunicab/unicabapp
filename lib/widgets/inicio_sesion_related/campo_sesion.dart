import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CampoSesion extends StatefulWidget {
  const CampoSesion({
    super.key, 
    this.fieldPlaceholder, 
    required this.fieldLabel, 
    required this.validator, 
    required this.fieldChecking,
    this.controller, 
  });

  final String fieldLabel;
  final String? fieldPlaceholder;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String? Function(String?, {required bool esRequerido}) fieldChecking;

  @override
  State<CampoSesion> createState() => _CampoSesionState();
}

class _CampoSesionState extends State<CampoSesion> {
  final fieldKey = GlobalKey<FormFieldState>();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder border = UnderlineInputBorder(

      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(16.sp),

    );

    final OutlineInputBorder borderError = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent.shade100, width: 2),
      borderRadius: BorderRadius.circular(16.sp),

    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),

      child: Column(
        children: [

          Row(
            children: [
              Text(
                widget.fieldLabel,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.sp,
                  color: Colors.white
                ),
              ),
            ],
          ),

          SizedBox(height: 9),

          TextFormField(
            key: fieldKey,
            controller: widget.controller,
            validator: widget.validator,

            onChanged: (value) {
              String? validatedValue = widget.fieldChecking(value, esRequerido: true);

              setState(() {
                errorText = validatedValue;
              });
            },

            decoration: InputDecoration(
              filled: true,
          
              enabledBorder: border,
              focusedBorder: border,

              errorBorder: borderError,
              focusedErrorBorder: borderError,

              hintText: widget.fieldPlaceholder,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp
              ),

              errorStyle: TextStyle(color: Colors.redAccent.shade100, fontFamily: 'Roboto'),
              errorText: errorText
            ),
            
            style: TextStyle(
              fontFamily: 'Roboto'
            ),
          ),

        ]
      ),
    );
  }
}