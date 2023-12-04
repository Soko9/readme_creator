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
    final Size size = MediaQuery.of(context).size;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      item.icon,
                      color: COLORS.back,
                      size: size.width * 0.02,
                    ),
                    if (constraints.minWidth >= SIZES.screenWidthThreshold)
                      FittedBox(
                        child: Text(
                          item.type,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            // fontSize: size.width * 0.01,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.25,
                            color: COLORS.back,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Draggable<BaseItem>(
            data: item,
            feedback: Opacity(
              opacity: 0.7,
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
