import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/estado_financiero/item_lista_financiero.dart';
import 'package:uniconecta/widgets/shared/main_navegation_bar.dart';

class EstadoFinanciero extends StatelessWidget {
  const EstadoFinanciero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating),
            SizedBox(height: 77),

            Text(
              "ESTADO FINANCIERO",
              style: TextStyle(
                color: Color.fromRGBO(134, 132, 129, 1),
                fontSize: 15,
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
                child: Column(
                  children: [
                    ItemListaFinanciero(itemTitle: "Pensiones Pagas", itemValue: "10"),
                    ItemListaFinanciero(itemTitle: "Fecha de corte", itemDescription: "(los primeros 10 dias de cada mes.)", itemValue: "7/3/2025"),
                    ItemListaFinanciero(itemTitle: "Intereses de no pago", itemDescription: "(Después de los 10 primeros días de cada mes)", itemValue: "\$ 10.000"),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}