import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/cuenta/cambiar_pass_response.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/repositories/cambiar_password_repository.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/inicio_sesion_related/campo_sesion.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class CambiarPassScreen extends StatelessWidget {
  const CambiarPassScreen({super.key});

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
                child: SafeArea(
                  child: _MainBody()
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        MainNavegationBar(navType: NavBarTypes.noBody),

        SizedBox(height: 10),
        
        Image.asset(
          'assets/img/LOGO UNICONECTA.png',
          height: 54,
          width: 154,
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Vamos a cambiar tu clave secreta.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontSize: 17.sp
                ),
              ),

              Text(
                "Shhh, ¡que nadie se entere cual es!",
                style: TextStyle(
                  color: const Color.fromARGB(255, 221, 221, 221),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontSize: 16.sp
                ),
              ),

              _MainForm()
            ],
          )
        )
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

  String? errorMsg;
  bool _loadingRequest = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController mainController;

  // Methods //
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

  Future<void> _sendRequest(BuildContext context) async {
    if (_loadingRequest) return;

    setState(() {
      _loadingRequest = true;
    });

    UserProvider provider = Provider.of<UserProvider>(context, listen: false);

    try {
      CambiarPassResponse response = await CambiarPasswordRepository.sendRequest(
        email: provider.user!.email,
        role: provider.user!.userRole,

        newPassword: mainController.text.trim(),
      );

      if (!context.mounted) return;

      if (response.status) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => GeneralScreen()), (Route<dynamic> route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromRGBO(11, 119, 179, 1), 
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 4),

                Text(response.mensaje, style: TextStyle(fontFamily: "Roboto", fontSize: 15.sp, color: Colors.white))
              ]
            )
          ),
        );

      } else {

        setState(() {
          errorMsg = response.mensaje;
        });

      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromRGBO(11, 119, 179, 1), 
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
        _loadingRequest = false;
      });
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (errorMsg != null) ...[
              SizedBox(height: 10),

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
                      errorMsg!,
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
            ] else SizedBox(height: 75),

          CampoSesion(
            fieldLabel: "Nueva Contraseña", 
            fieldPlaceholder: "¿Cual sera tu nueva clave secreta?",
          
            controller: mainController,
            fieldChecking: CustomFormFieldValidator.password,
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Ingresa un valor.";
              } else { 
                return CustomFormFieldValidator.correo(value, esRequerido: true);
              }
            }, 
          ),

          SizedBox(height: 50),

          (!_loadingRequest) 
              ? OrangeButton(
                  onPressed: () => _sendRequest(context),

                  buttonText: "Actualizar",
                  textWeight: FontWeight.w600,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h), 
                )

              : SizedBox(height: 26, width: 26, child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }

}