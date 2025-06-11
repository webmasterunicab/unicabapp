import 'package:flutter/material.dart';

class SenderMessageBubble extends StatelessWidget {
  const SenderMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final double espaciado = 25;

    final estilosBurbujaMensaje = BoxDecoration(
      color: Color.fromRGBO(221, 219, 215, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    );

    final anchoPantalla = MediaQuery.of(context).size.width;

    final mensaje = 'Hola!';

    final mensajeLargo =
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas efficitur lorem at finibus. Integer eget tellus id lorem aliquam ultricies. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc vel lacus posuere, pulvinar mi eget, tempus libero. In non diam at augue efficitur efficitur id tempor dolor. Integer posuere tristique lectus, sed cursus nibh. Donec dignissim sem sit amet turpis accumsan facilisis. Donec volutpat arcu ac rhoncus pharetra. Nullam dignissim rhoncus diam. Etiam sit amet risus sed mauris suscipit ornare.

Cras dignissim id massa vitae interdum. Curabitur ultrices neque imperdiet, tempus metus vestibulum, viverra dui. Nullam est magna, iaculis at neque vel, ornare maximus ante. Aliquam non lacus nunc. Phasellus id ante at purus fermentum laoreet eget a dolor. Ut id lorem elit. Donec in sodales elit, ac hendrerit eros. In at luctus lacus. Maecenas suscipit, tellus tempor hendrerit fringilla, quam metus ultricies magna, in rhoncus justo libero quis urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Vestibulum pellentesque finibus justo. Fusce at blandit risus, sit amet cursus augue. Aenean porta rhoncus tristique. Vivamus commodo tellus in augue dapibus tempus. Integer tempus neque nec arcu vulputate, eu rhoncus nibh ornare. Ut non dolor sodales justo tincidunt dictum ut eu ex. Suspendisse lacinia nunc quam, vel ultricies lorem dictum a. In orci est, ultricies in felis in, gravida commodo tortor. Quisque eleifend lorem a libero suscipit semper. Vivamus id elit sit amet ante lacinia ullamcorper.

Nam suscipit nunc ut blandit vehicula. Ut consequat elit risus, eu tincidunt urna imperdiet vel. Nulla convallis semper sem, a rutrum ex pellentesque non. Nam egestas nisi metus, ut vehicula purus eleifend nec. Donec sem nisl, rhoncus vel sapien non, ornare efficitur tortor. Proin felis nulla, dictum quis blandit sed, mattis vitae nisl. Nam tincidunt, metus et dignissim feugiat, elit eros imperdiet est, non fringilla dolor ligula non lacus. Cras finibus, ligula a commodo semper, dolor odio auctor ante, vitae tincidunt dolor urna nec felis.

Integer a nisl velit. Mauris laoreet in urna sed tincidunt. Suspendisse potenti. Quisque orci quam, gravida ac blandit quis, tempor quis mi. Quisque a nulla orci. Phasellus tempus, odio eu facilisis condimentum, magna enim consectetur magna, ullamcorper tincidunt lorem diam a felis. Phasellus consequat justo laoreet porta congue. Praesent vitae tellus sagittis, vestibulum nunc lacinia, laoreet turpis.''';

    final DateTime ahora = DateTime.now();

    List<String> meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    final fecha = Container(
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Text(
        '${ahora.day} de ${meses[ahora.month - 1]} del ${ahora.year}',
        style: TextStyle(color: Color.fromRGBO(134, 132, 129, 1), fontSize: 13),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: espaciado,
        ),
        Text('Tú'),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: estilosBurbujaMensaje,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: anchoPantalla * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(mensajeLargo),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: fecha,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: espaciado,
        ),
      ],
    );
  }
}
