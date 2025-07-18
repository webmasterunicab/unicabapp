import 'package:flutter/material.dart';

class ItemListaFinanciero extends StatelessWidget {
  const ItemListaFinanciero({super.key, required this.itemTitle, this.itemDescription = "", required this.itemValue, this.isLastItem = false});

  final String itemDescription;

  final String itemTitle;
  final String itemValue;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    final BorderSide border = (!isLastItem) 
      ? BorderSide(
          color: Color.fromRGBO(41, 39, 36, 0.2), // gris claro (puedes cambiarlo)
          width: 1,
        )
      : BorderSide(color: Colors.transparent);

    return SizedBox(
      width: 284,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: border
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemTitle,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(14, 14, 14, 1),
                    fontSize: 13,
                  ),
                ),

                if (itemDescription.isNotEmpty) Text(itemDescription, style: TextStyle(fontSize: 8, color: Color.fromRGBO(14, 14, 14, 1))),
              ],
            ),

            Text(
              itemValue,
              style: TextStyle(
                color: Color.fromRGBO(255, 152, 5, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}