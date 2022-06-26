import 'package:flutter/material.dart';

dailogueShow({
  Function()? sendCode,
  required BuildContext context,
  required String content,
  required String title,
  required Function() function,
}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: function,
              child: const Text("Exit"),
            ),
            TextButton(onPressed: () {}, child: const Text("Send link"))
          ],
          content: Text(content),
        );
      });
}
