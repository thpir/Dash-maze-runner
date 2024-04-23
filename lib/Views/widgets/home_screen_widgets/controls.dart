import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController gameController = Provider.of<GameController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Image.asset(
            "assets/images/arrow_left.png",
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          onTap: () => gameController.moveLeft(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Image.asset(
                "assets/images/arrow_up.png",
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              onTap: () => gameController.moveUp(),
            ),
            InkWell(
              child: Image.asset(
                "assets/images/arrow_down.png",
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              onTap: () => gameController.moveDown(),
            ),
          ],
        ),
        InkWell(
          child: Image.asset(
            "assets/images/arrow_right.png",
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          onTap: () => gameController.moveRight(),
        ),
      ],
    );
  }
}