import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';

class SeguimientoCard extends StatelessWidget {
  const SeguimientoCard({super.key, required this.acuerdos, required this.pensamiento, required this.status, required this.date});

  final String acuerdos;
  final String pensamiento;
  final String date;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 28),

      width: double.infinity,
      height: 180,

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ],
      ),

      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33), 
                  child: Text(acuerdos, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 10, color: Color.fromRGBO(14, 14, 14, 1)))
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33), 
                  child: Text(pensamiento, style: TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.italic, fontSize: 13, color: Color.fromRGBO(134, 132, 129, 1)))
                ),

                Container(margin: EdgeInsets.symmetric(horizontal: 33), child: TextArea(fieldHeight: 80, readOnly: true)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33, vertical: 5), 
                  child: Text(date, style: TextStyle(fontFamily: 'Roboto', fontSize: 7))
                ),
              ],
            ),
          ),

          Expanded(
            flex: 3,
            child: _VerticalTimeline(status: status)
          )
        ],
      ),
    );
  }
}

class _VerticalTimeline extends StatelessWidget {
  const _VerticalTimeline({required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    final labels = ["Cumplido", "En proceso", "Pendiente", "Fallas"];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final bool isLast = index == labels.length - 1;
        final bool isActive = index == status;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline + punto
            Column(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.white,
                    shape: BoxShape.circle,
                    border: !isActive ? Border.all(
                      color: Colors.grey,
                      width: 1,
                    ) : Border.all(color: Colors.transparent)
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 1,
                    height: 8,
                    color: Colors.grey,
                  ),
              ],
            ),
            const SizedBox(width: 8),
            // Texto
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                labels[index],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 9
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}