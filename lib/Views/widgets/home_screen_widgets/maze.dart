import 'package:dash_maze_runner/data/mazes.dart';
import 'package:flutter/material.dart';

class Maze extends StatelessWidget {
  const Maze({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> getMaze() {
      List<Widget> children = [];
      for (int i = 0; i < mazeLevel001.length; i++) {
        for (int j = 0; j < mazeLevel001[i].length; j++) {
          if (mazeLevel001[i][j] == "r") {
            children.add(Image.asset("assets/images/rock.png"));
          } else if (mazeLevel001[i][j] == "l") {
            children.add(Image.asset("assets/images/lock.png"));
          } else if (mazeLevel001[i][j] == "f") {
            children.add(Image.asset("assets/images/trophy.png"));
          } else {
            children.add(Container(
              color: Colors.transparent,
            ));
          }
        }
      }
      return children;
    }

    return Column(
      children: [
        SizedBox(
          width: width,
          height: width,
          child: GridView.count(
              padding: EdgeInsets.all(width * 0.03),
              crossAxisCount: mazeLevel001.length,
              children: getMaze()),
        ),
      ],
    );
  }
}
