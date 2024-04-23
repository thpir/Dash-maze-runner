import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameActions extends StatelessWidget {
  const GameActions({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: gameController.resetGame, 
            style: ElevatedButton.styleFrom(
              foregroundColor: buttonTextColor,
              backgroundColor: buttonBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: const Text(
              "Reset Game",
              style: TextStyle(
                fontFamily: "theren"
              ),
            )
          )
        ],
      ),
    );
  }
}