import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({super.key, required this.title, required this.thumbnailPath, required this.route});

  final String title;
  final String thumbnailPath;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 142,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => route));
        },
      
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(thumbnailPath, fit: BoxFit.contain)
            ),
            
            SizedBox(height: 27,),

            Text(title, style: TextStyle(fontSize: 10, fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Color.fromRGBO(100, 96, 92, 0.7))),
          ],
        ),
      ),
    );
  }
}