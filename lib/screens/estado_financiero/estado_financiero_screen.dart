import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/repositories/financiero_repository.dart';
import 'package:uniconecta/widgets/estado_financiero/boton_azul_financiero.dart';
import 'package:uniconecta/widgets/estado_financiero/item_lista_financiero.dart';
import 'package:uniconecta/widgets/estado_financiero/resultado_financiero.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';

class EstadoFinanciero extends StatelessWidget {
  final String obtainedEmail;

  const EstadoFinanciero({super.key, required this.obtainedEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
            SizedBox(height: 84),

            Container(
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
                  future: FinancieroRepository.getFinancial(role: 1, email: obtainedEmail), 
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
                            ItemListaFinanciero(itemTitle: "Pensiones Pagas", itemValue: "${data.pensionesPagas}"),
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
            ),
            SizedBox(height: 60),

            Text(
              "Subir soporte de pago", 
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 13.sp
              ),
            ),
            SizedBox(height: 25),

            BotonAzulFinanciero(buttonText: "Seleccionar", prefix: Image.asset('assets/img/pictureIcon.png', fit: BoxFit.contain, width: 16, height: 16), weight: FontWeight.normal),
            SizedBox(height: 25),
            
            BotonAzulFinanciero(buttonText: "Enviar", fontSize: 15, paddingRadius: EdgeInsets.symmetric(horizontal: 56, vertical: 22)),
            SizedBox(height: 20),

            ResultadoFinanciero(operationSuccess: true)
          ],
        ),
      ),
    );
  }
}