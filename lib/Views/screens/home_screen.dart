import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/background.dart';
import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/controls.dart';
import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/dash.dart';
import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/game_actions.dart';
import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/maze.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
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
        ],
      )
    );
  }
}