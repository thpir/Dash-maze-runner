import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';

class OcrAppbar extends StatelessWidget implements PreferredSizeWidget{
  const OcrAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Scan text to unlock",
        style: TextStyle(fontFamily: "super_boys"),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: buttonTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      foregroundColor: buttonTextColor,
      backgroundColor: buttonBackgroundColor,
      centerTitle: true,
      bottom: null,
    );
  }
}