import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/helpers/inicio_sesion_helper.dart';
import 'package:uniconecta/models/inicio_sesion/response_login.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/screens/recuperar_contrasena/recuperar_contrasena_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/inicio_sesion_related/campo_sesion.dart';
import 'package:uniconecta/widgets/inicio_sesion_related/custom_button_sesion.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class InicioSesion extends StatelessWidget {
  const InicioSesion({super.key});

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
                child: _InicioBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InicioBody extends StatelessWidget {
  const _InicioBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainNavegationBar(navType: NavBarTypes.noBody),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 51),
                child: Image.asset(
                  'assets/img/LOGO UNICONECTA.png',
                  height: 54,
                  width: 154,
                ),
              ),
              SizedBox(height: 138),
    
              _MainForm(),
    
              SizedBox(height: 42),
          
              CustomButtonSesion(
                buttonText: "Olvide mi contraseña",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecuperarContrasenaScreen()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MainForm extends StatefulWidget {
  const _MainForm();

  @override
  State<_MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<_MainForm> {
  String? error;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      child: Column(
      children: [
        CampoSesion(
          fieldLabel: "Usuario (Correo)", 
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

        SizedBox(height: 47),
      
        CampoSesion(
          fieldLabel: "Contraseña", 
          fieldChecking: CustomFormFieldValidator.password,

          controller: passwordController, 
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return "Ingresa un valor.";
            } else { 
              return CustomFormFieldValidator.password(value, esRequerido: true);
            }
          }
        ),

        SizedBox(height: 34),

        if (error != null)
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), 
            child: Text(error!, style: TextStyle(fontSize: 16.sp, color: Colors.redAccent.shade100, fontFamily: 'Roboto'))
          ),

        Builder(
          builder: (context) {
            return OrangeButton(
              buttonText: "Iniciar Sesión",
              onPressed: () async {
                if (Form.of(context).validate()) {
                  InicioSesionHelper helper = InicioSesionHelper();
                  ResponseLogin loginResponse = await helper.sendLoginRequest(
                    emailController.text.trim(), 
                    passwordController.text.trim()
                  );
                  
                  if (!context.mounted) return;

                  if (loginResponse.canLogin) {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => GeneralScreen()), (Route<dynamic> route) => false);
                  } else {
                    setState(() {
                      error = loginResponse.message;
                    });
                  }
                }
              },
              textWeight: FontWeight.w600,
            );
          }
        ),
      ],
    ));
  }
}