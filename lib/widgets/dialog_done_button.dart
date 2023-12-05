import "package:flutter/material.dart";

class DialogDoneButton extends StatelessWidget {
  final VoidCallback onPress;

  const DialogDoneButton({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Text(
          "Done",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
