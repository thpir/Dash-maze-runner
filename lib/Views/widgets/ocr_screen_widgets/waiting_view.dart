import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black12,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: buttonBackgroundColor,),
    );
  }
}