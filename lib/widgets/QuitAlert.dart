import 'package:flutter/material.dart';

class QuitAlert extends StatelessWidget {
  Function onExit;
  QuitAlert({super.key, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit Game'),
      content: const Text('Are you sure ?'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () => onExit(),
        ),
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
