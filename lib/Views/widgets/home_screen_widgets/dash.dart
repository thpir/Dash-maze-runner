import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:dash_maze_runner/data/mazes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  List<Widget> getDashLocation(int x, int y) {
    List<Widget> children = [];
    for (int i = 0; i < mazeLevel001.length; i++) {
      for (int j = 0; j < mazeLevel001[i].length; j++) {
        if (i == x && j == y) {
          children.add(Image.asset(
            "assets/images/dash.png",
          ));
        } else {
          children.add(Container(
            color: Colors.transparent,
          ));
        }
      }
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: width,
          height: width,
          child: GridView.count(
              padding: EdgeInsets.all(width * 0.03),
              crossAxisCount: mazeLevel001.length,
              children: getDashLocation(
                  gameController.currentY, gameController.currentX)),
        ),
      ],
    );
  }
}
