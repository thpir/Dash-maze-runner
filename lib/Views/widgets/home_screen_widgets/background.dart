import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: 
            DecorationImage(
              image: AssetImage('assets/images/grass.jpg'),
              fit: BoxFit.cover,
            ),
        ),
      );
  }
}