import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({super.key, required this.prefixIcon, required this.text, required this.suffixIcon});

  final IconData prefixIcon;
  final String text;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {  },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(prefixIcon, color: Colors.white,),
                const SizedBox(width: 10,),
                Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
            Icon(suffixIcon, color: Colors.white, size: 15,),
          ],
        ),
      ),
    );
  }
}
