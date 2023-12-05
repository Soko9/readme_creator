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
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(4.0),
          // gradient: RadialGradient(
          //   colors: [
          //     Theme.of(context).colorScheme.primaryContainer,
          //     Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          //   ],
          //   center: Alignment.center,
          //   // radius: 10.0,
          //   tileMode: TileMode.mirror,
          // ),
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        ),
        margin:
            EdgeInsets.symmetric(horizontal: 12.0, vertical: verticalMargin),
        child: Center(
          child: Image.asset(
            ASSETS.drop,
            width: 28.0,
            height: 28.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      onAccept: onAccept,
    );
  }
}
