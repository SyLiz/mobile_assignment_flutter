import 'package:flutter/material.dart';

class PopupAboutMe extends StatelessWidget {
  const PopupAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("About me"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text("Pongsatorn Ploypukdee"), Text("p.ploypukdee@gmail.com")],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    );
  }
}
