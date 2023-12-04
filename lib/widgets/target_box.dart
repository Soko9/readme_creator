import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";

import "../items/base_item.dart";

class TargetBox extends StatelessWidget {
  final void Function(BaseItem<Object> data)? onAccept;
  final double height;
  final double verticalMargin;

  const TargetBox({
    super.key,
    required this.onAccept,
    required this.height,
    required this.verticalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<BaseItem>(
      builder: (_, __, ___) => Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: COLORS.border.withOpacity(0.25),
        ),
        margin:
            EdgeInsets.symmetric(horizontal: 12.0, vertical: verticalMargin),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 24.0,
            color: COLORS.primary,
          ),
        ),
      ),
      onAccept: onAccept,
    );
  }
}
