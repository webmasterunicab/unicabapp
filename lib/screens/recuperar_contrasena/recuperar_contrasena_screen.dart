import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/inicio_sesion_related/campo_sesion.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RecuperarContrasenaScreen extends StatelessWidget {
  const RecuperarContrasenaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 119, 179, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    MainNavegationBar(navType: NavBarTypes.noBody),

                    Expanded(
                      child: _ScreenBody(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 51),
          child: Image.asset(
            'assets/img/LOGO UNICONECTA.png',
            width: 154,
            height: 54,
          ),
        ),
        SizedBox(height: 75),
    
        Text("¿Deseas recuperar tu contraseña?", style: TextStyle(fontFamily: 'Roboto', fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.w700)),
        Text("Permitenos ayudarte.", style: TextStyle(fontFamily: 'Roboto', fontSize: 16.sp, color: const Color.fromRGBO(221, 221, 221, 1), fontWeight: FontWeight.w500)),
    
        SizedBox(height: 75),
    
        Form(
          child: Column(
          children: [
            CampoSesion(
              fieldLabel: "Correo Electronico", 
              fieldPlaceholder: "¡Para enviarte un codigo secreto!", 
              
              fieldChecking: CustomFormFieldValidator.correo,
              controller: emailController,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "Ingresa un valor.";
                } else { 
                  return CustomFormFieldValidator.correo(value, esRequerido: true);
                }
              }
            ),
            SizedBox(height: 75),
    
            OrangeButton(buttonText: "Enviar", textWeight: FontWeight.w600, padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h), onPressed: () {
              if (Form.of(context).validate()) {
                
              }
            })
          ],
        ))
      ],
    );
  }
}
