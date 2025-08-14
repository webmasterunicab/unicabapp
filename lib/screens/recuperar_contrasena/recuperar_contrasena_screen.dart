import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/repositories/inicio_sesion_repository.dart';
import 'package:uniconecta/models/inicio_sesion/response_recover_pass.dart';
import 'package:uniconecta/screens/recuperar_contrasena/recuperar_contrasena_exito_screen.dart';
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

class _ScreenBody extends StatefulWidget {
  const _ScreenBody();

  @override
  State<_ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<_ScreenBody> {
  String? errorMsg;
  late TextEditingController mainController;
  
  @override
  void initState() {
    super.initState();
    mainController = TextEditingController();
  }

  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: mainController,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "Ingresa un valor.";
                } else { 
                  return CustomFormFieldValidator.correo(value, esRequerido: true);
                }
              }
            ),

            (errorMsg != null) 
              ? Container(
                margin: EdgeInsets.symmetric(vertical: 22.sp, horizontal: 33.sp), 
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  borderRadius: BorderRadius.circular(8.sp)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded, color: Colors.redAccent.shade700, size: 20.sp),
                    SizedBox(height: 10.sp),
                    Text(errorMsg!, softWrap: true, textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, color: Colors.redAccent.shade700, fontFamily: 'Roboto')),
                  ],
                )
              ) 
              : SizedBox(height: 75),

            Builder(
              builder: (context) {
                return OrangeButton(
                  buttonText: "Enviar", 
                  textWeight: FontWeight.w600, 
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h), 
                
                  onPressed: () async {
                    if (Form.of(context).validate()) {
                      ResponseRecoverPass response = await InicioSesionRepository.sendRecoveryRequest(
                        mainController.text.trim(), 
                      );
                
                      if (!context.mounted) return;
                
                      if (response.recoverStatus) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => RecuperarContrasenaExitoScreen()), (Route<dynamic> route) => false);
                      } else {
                        setState(() {
                          errorMsg = response.message;
                        });
                      }
                    }
                  }
                );
              }
            )
          ],
        ))
      ],
    );
  }
}