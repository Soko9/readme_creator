import "dart:ui";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:readme_creator/controllers/canvas_controller.dart";
import "package:readme_creator/items/base_item.dart";
import "package:readme_creator/items/items.dart";
import "package:readme_creator/widgets/dialog_form.dart";
import "package:readme_creator/widgets/target.dart";
import "package:readme_creator/widgets/target_box.dart";

class CanvasSheet extends StatefulWidget {
  const CanvasSheet({super.key});

  @override
  State<CanvasSheet> createState() => _CanvasSheetState();
}

class _CanvasSheetState extends State<CanvasSheet> {
  void accept({
    required BuildContext context,
    required BaseItem<Object> item,
    required void Function(BaseItem<Object> item) whenAccept,
  }) {
    showDialog(
      context: context,
      builder: (_) => DialogForm(
        item: item,
        whenAccept: whenAccept,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<CanvasController>(
      builder: (_, controller, __) => Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: SizedBox(
          width: size.width * 0.8,
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final BaseItem item = controller.removeItemAt(index: oldIndex);
                controller.insertItemAt(index: newIndex, item: item);
              });
            },
            buildDefaultDragHandles: false,
            footer: TargetBox(
              key: const Key("dragTarget"),
              height: MediaQuery.of(context).size.height * 0.15,
              verticalMargin: 24.0,
              onAccept: (data) => data is DividerItem
                  ? controller.addItem(item: data)
                  : accept(
                      context: context,
                      item: data,
                      whenAccept: (item) {
                        controller.addItem(item: item);
                        Navigator.pop(context);
                      },
                    ),
            ),
            proxyDecorator: (child, index, animation) => AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                final double animValue =
                    Curves.easeInOut.transform(animation.value);
                final double scale = lerpDouble(
                  1.0,
                  1.1,
                  animValue,
                )!;
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: child,
            ),
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              controller.items.length,
              (index) => ReorderableDragStartListener(
                key: Key(index.toString()),
                index: index,
                child: Target(
                  item: controller.items[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
