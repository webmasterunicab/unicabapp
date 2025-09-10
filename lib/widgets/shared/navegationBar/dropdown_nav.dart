import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/navegationBar/dropdown_item_nav.dart';

class DropdownNav extends StatelessWidget {
  final double boxSize;
  final List<DropdownItemNav> items;

  const DropdownNav({super.key, required this.items, required this.boxSize});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: (40 * items.length).toDouble(),
      width: boxSize,
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 242, 240, 1),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16), offset: Offset(0, 3), blurRadius: 6)
        ]
      ),
      
      child: Column(
        children: items,
      ),
    );
  }
}