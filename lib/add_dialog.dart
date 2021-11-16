
import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class AddDialog extends StatelessWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("in build");
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
