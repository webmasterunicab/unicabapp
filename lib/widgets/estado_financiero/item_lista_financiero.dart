import 'package:flutter/material.dart';

class ItemListaFinanciero extends StatelessWidget {
  const ItemListaFinanciero({super.key, required this.itemTitle, this.itemDescription = "", required this.itemValue});

  final String itemDescription;

  final String itemTitle;
  final String itemValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 284,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(41, 39, 36, 0.2), // gris claro (puedes cambiarlo)
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemTitle,
                  style: TextStyle(
                    color: Color.fromRGBO(14, 14, 14, 1),
                    fontSize: 12,
                  ),
                ),

                if (itemDescription.isNotEmpty) Text(itemDescription, style: TextStyle(fontSize: 7, color: Color.fromRGBO(14, 14, 14, 1))),
              ],
            ),

            Text(
              itemValue,
              style: TextStyle(
                color: Color.fromRGBO(255, 152, 5, 1),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}