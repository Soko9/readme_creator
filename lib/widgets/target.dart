import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/controllers/canvas_controller.dart";
import "package:readme_creator/items/base_item.dart";
import "package:readme_creator/items/items.dart";

import "wrapper.dart";

class Target<T extends Object> extends StatelessWidget {
  final BaseItem<Object> item;

  const Target({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String target = "";
    switch (item) {
      case HeaderItem():
        target =
            "Header ${(item as HeaderItem).header.hash.length}:\n${item.title}";
        break;
      case FencedCodeItem():
        target =
            "Fenced Code (${(item as FencedCodeItem).language.name}):\n${item.title}";
      case ListItem():
        target =
            "${(item as ListItem).listType.name[0].toUpperCase() + (item as ListItem).listType.name.substring(1)} List:\n${"[${(item as ListItem).items.map((e) => "$e ")}]"}";
        break;
      case DividerItem():
        target = "";
        break;
      default:
        target = "${item.type}:\n${item.title}";
    }
    final Widget child = item is DividerItem
        ? IntrinsicHeight(
            child: SizedBox(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                tileColor: COLORS.border.withOpacity(0.7),
                // leading: const Icon(
                //   Icons.drag_indicator_rounded,
                //   size: 20.0,
                //   color: COLORS.primary,
                // ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<CanvasController>(context, listen: false)
                        .removeItem(item: item);
                  },
                  icon: const Icon(Icons.remove),
                  iconSize: 20.0,
                  color: COLORS.delete,
                  splashRadius: 2.0,
                ),
              ),
            ),
          )
        : Wrapper(
            child: ListTile(
              title: Wrapper(
                child: Text(
                  target,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: COLORS.back,
                  ),
                ),
              ),
              // leading: const Icon(
              //   Icons.drag_indicator_rounded,
              //   size: 24.0,
              //   color: COLORS.back,
              // ),
              trailing: IconButton(
                onPressed: () {
                  Provider.of<CanvasController>(context, listen: false)
                      .removeItem(item: item);
                },
                icon: const Icon(Icons.remove),
                iconSize: 24.0,
                color: COLORS.delete,
                splashRadius: 2.0,
              ),
            ),
          );

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
