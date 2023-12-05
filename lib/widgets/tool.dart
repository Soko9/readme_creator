import "dart:math";

import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/base_item.dart";
import "package:readme_creator/widgets/wrapper.dart";

class Tool<T extends Object> extends StatelessWidget {
  final BaseItem item;
  const Tool({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget child = Material(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.transparent,
          child: Tooltip(
            message: item.type,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            preferBelow: false,
            child: Wrapper(
              child: Center(
                child: Image.asset(
                  item.icon,
                  width: SIZES.iconSize,
                  height: SIZES.iconSize,
                  color: COLORS.primary,
                ),
              ),
            ),
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Draggable<BaseItem>(
            data: item,
            feedback: Transform.rotate(
              angle: pi / 12.0,
              child: child,
            ),
            childWhenDragging: child,
            child: child,
          ),
        );
      },
    );
  }
}
