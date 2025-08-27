import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/repositories/inicio_sesion_repository.dart';
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
  // Variables //
  String? error;
  bool _joiningSession = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Methods //

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Send a login request to the server, if everything passes, logs in automatically.
  // Needs a StatefulWidget BuildContext.
  Future<void> _sendRequest(BuildContext context) async {
    if (_joiningSession) return;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _joiningSession = true;
      });

      try {

        final String email = emailController.text.trim();
        ResponseLogin loginResponse = await InicioSesionRepository.sendLoginRequest(
          email,
          passwordController.text.trim(),
          context: context,
        );

        if (!context.mounted) return;

        if (loginResponse.canLogin) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => GeneralScreen(userEmail: email),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          setState(() {
            error = loginResponse.message;
          });
        }

      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent, 
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Icon(Icons.error_rounded, color: Colors.white),
                SizedBox(width: 4),

                Text("Ha Ocurrido un error, Revisa tu conexion a internet.", style: TextStyle(fontFamily: "Roboto", fontSize: 15.sp, color: Colors.white))
              ]
            )
          ),
        );

      } finally {

        setState(() {
          _joiningSession = false;
        });

      }
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (error != null) ...[
            SizedBox(height: 20),

            Container(
              margin: EdgeInsets.symmetric(vertical: 22.sp, horizontal: 33.sp),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 119, 144, 1),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                border: BoxBorder.all(color: Color.fromRGBO(255, 23, 68, 1), width: 2)
              ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error!,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ] else SizedBox(height: 100),

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
            },
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
            },
          ),
          SizedBox(height: 30),

          (!_joiningSession) 
            ? OrangeButton(
                onPressed: () => _sendRequest(buildContext),

                buttonText: "Iniciar Sesión",
                textWeight: FontWeight.w600,
              )

            : SizedBox(height: 26, width: 26, child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }
}
