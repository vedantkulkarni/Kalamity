import 'package:flutter/material.dart';
import 'package:pict_vit/constants.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({Key? key, required this.name, required this.img})
      : super(key: key);

  final String name, img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .43,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: mainThemeBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage(img), fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
//AssetImage(img)
