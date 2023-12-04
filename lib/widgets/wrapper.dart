import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: COLORS.primary,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
