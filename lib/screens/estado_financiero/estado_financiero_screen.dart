import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/financiero/send_support_model.dart';
import 'package:uniconecta/repositories/financiero_repository.dart';
import 'package:uniconecta/widgets/estado_financiero/boton_azul_financiero.dart';
import 'package:uniconecta/widgets/estado_financiero/item_lista_financiero.dart';
import 'package:uniconecta/widgets/estado_financiero/resultado_financiero.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';

class EstadoFinanciero extends StatelessWidget {
  final String obtainedEmail;
  final String studentName;

  const EstadoFinanciero({super.key, required this.obtainedEmail, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: _FinancieroBody(email: obtainedEmail, name: studentName),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FinancieroBody extends StatelessWidget {
  final String email;
  final String name;

  const _FinancieroBody({required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating, ),
            SizedBox(height: 77),

            Text(
              "ESTADO FINANCIERO",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromRGBO(134, 132, 129, 1),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromRGBO(134, 132, 129, 1),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 42),

            _MainCards(email: email),

            SizedBox(height: 60),

            Text(
              "Subir soporte de pago", 
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 14.sp
              ),
            ),
            SizedBox(height: 4),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "Importante: El soporte de pago tiene que tener la siguiente estructura en el nombre: numeroDocumento_Año_conceptoPago", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            SizedBox(height: 25),

            _SoportePagoButtons()
          ],
        ),
      );
  }
}

class _SoportePagoButtons extends StatefulWidget {
  const _SoportePagoButtons();

  @override
  State<_SoportePagoButtons> createState() => _SoportePagoButtonsState();
}

class _SoportePagoButtonsState extends State<_SoportePagoButtons> {
  bool _pickerActive = false;
  bool _operationSuccess = false;
  bool _previewEnabled = false;
  bool _isSending = false;

  String? _message;
  File? _selectedFile;
  String? _fileName;

  String? _checkFileFormat(String value) {
    final regex = RegExp(r'^[0-9]+-\d{4}-(mocp|m|ocp|dg|icfes|p|pp|pm[1-9]|pm10)$');

    if (!regex.hasMatch(value)) {
      return 'El soporte no cumple con el formato especificado.';
    }

    return null;
  }

  Future<void> _selectFile() async {
    if (_pickerActive) return;

    setState(() {
      _pickerActive = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg'],
      );

      if (result != null) {

        // Checking if name passes the regex check.
        final String name = result.files.single.name;
        final String? checking = _checkFileFormat(name.substring(0, name.lastIndexOf('.')));

        if (checking != null) {

          setState(() {
            _message = checking;
            _operationSuccess = false;
          });

        } else {
          final String name = result.files.single.name;

          setState(() {
            _selectedFile = File(result.files.single.path!);
            _fileName = name;
            _message = null;
          });

          if (name.substring(name.lastIndexOf('.') + 1, name.length) != "pdf") {

            // Show a preview of the image
            setState(() {
              _previewEnabled = true;
            });

          } else {

            // Disable Preview if file is a pdf
            setState(() {
              _previewEnabled = false;
            });

          }

        }
      }

    } catch (e) {

      setState(() {
        _message = "Ha ocurrido un error.";
        _operationSuccess = false;
      });

    } finally {

      setState(() {
        _pickerActive = false;
      });

    }
  }

  Future<void> _sendSupport() async {
    if (_isSending) return;

    if (_selectedFile != null) {

      setState(() {
        _isSending = true;
      });

      try {

        SendSupportModel response = await FinancieroRepository.sendSupport(file: _selectedFile!);

        setState(() {
          _message = response.message;
          _operationSuccess = response.success;
        });

      } catch (e) {

        setState(() {
          _message = "Ha ocurrido un error.";
          _operationSuccess = false;
        });

      } finally {

        setState(() {
          _isSending = false;
        });

      }

    } else {
      
      setState(() {
        _message = "Selecciona un archivo primero.";
        _operationSuccess = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        BotonAzulFinanciero(
          onPressed: _selectFile,

          buttonText: "Seleccionar", 
          prefix: Image.asset('assets/img/pictureIcon.png', fit: BoxFit.contain, width: 16, height: 16), 
          weight: FontWeight.normal
        ),

        SizedBox(height: 10),

        if (_selectedFile != null)
          Text(
            "Seleccionaste: $_fileName", 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),

        if (_previewEnabled && _selectedFile != null) ...[
          SizedBox(height: 8),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: 200,
            width: 80.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),

            child: Image.file(_selectedFile!),
          )
        ],
          

        SizedBox(height: 25),
        
        (!_isSending) 
            ? BotonAzulFinanciero(
              onPressed: _sendSupport,

              buttonText: "Enviar", 
              fontSize: 15, 
              paddingRadius: EdgeInsets.symmetric(horizontal: 56, vertical: 22)
            ) : SizedBox(height: 26, width: 26, child: CircularProgressIndicator()),

        SizedBox(height: 20),
        
        if (_message != null)
          ResultadoFinanciero(operationSuccess: _operationSuccess, message: _message),

        SizedBox(height: 20),
      ],
    );
  }
}

class _MainCards extends StatelessWidget {
  final String email;

  const _MainCards({
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 242, 240, 1), 
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ],
      ),
      
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: FutureBuilder(
          future: FinancieroRepository.getFinancial(role: 1, email: email), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}", textAlign: TextAlign.center,);
            } else {
              final data = snapshot.data!.financieroData;

              if (snapshot.data!.financieroCargado && data != null) {
                return Column(
                  children: [
                    ItemListaFinanciero(
                      itemTitle: "Deuda anterior", 
                      itemValue: "\$ ${data.deudaAnterior}", 
                      suffix: Text(
                        (data.deudaAnterior < 1) ? "PAGADA" : "PENDIENTE", 
                        style: TextStyle(
                          color: (data.deudaAnterior < 1) ? Color.fromRGBO(36, 255, 36, 1) : Color.fromARGB(255, 255, 99, 99), 
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp
                        )
                      )
                    ),
    
                    ItemListaFinanciero(itemTitle: "Valor de matrícula", itemValue: "\$ ${data.valorMatricula}"),
    
                    if (data.derechosGradoPago)
                      ItemListaFinanciero(itemTitle: "Derechos de Grado", itemValue: "\$ ${data.derechosGradoValor}"),
    
                    if (data.icfesPago)
                      ItemListaFinanciero(itemTitle: "Icfes", itemValue: "\$ ${data.icfesValor}"),
    
                    ItemListaFinanciero(itemTitle: "Pensiones Pagas", itemValue: "${data.pensionesPagas}"),
                    ItemListaFinanciero(itemTitle: "Pensiones Pendientes", itemValue: "${data.pensionesPendientes}"),
    
                    ItemListaFinanciero(itemTitle: "Intereses de no pago", itemDescription: "(Después de los 10 primeros días de cada mes)", itemValue: "\$ ${data.interesNoPago}"),
                    ItemListaFinanciero(itemTitle: "Saldo pendiente", itemValue: "\$ ${data.saldoPendiente}"),
                    ItemListaFinanciero(itemTitle: "Total pagado", itemValue: "\$ ${data.totalPagado}", isLastItem: true),
                  ],
                );
              } else {
                return Text("No hay informacion financiera obtenida.", textAlign: TextAlign.center,);
              }
              
            }
          }
        )
      )
    );
  }
}