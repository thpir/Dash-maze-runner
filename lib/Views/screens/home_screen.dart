import 'package:dash_maze_runner/views/widgets/home_screen_widgets/background.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/confetti_overlay.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/controls.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/dash.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/game_actions.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/maze.dart';
import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {  
    final gameController = Provider.of<GameController>(context);
    gameController.context = context;  
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GameActions(),
              Stack(
                children: [
                  Maze(),
                  Dash(),
                ],
              ),
              Controls()
            ],
          ),
          if (gameController.gameFinished) const ConfettiOverlay(),
        ],
      )
    );
  }
}