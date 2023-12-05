import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/controllers/canvas_controller.dart";
import "package:readme_creator/items/base_item.dart";
import "package:readme_creator/items/items.dart";

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
            "Header ${(item as HeaderItem).header.hash.length}:\n${item.toYaml()}";
        break;
      case FencedCodeItem():
        target =
            "Fenced Code (${(item as FencedCodeItem).language.name}):\n${item.toYaml()}";
      case ListItem():
        target =
            "${(item as ListItem).listType.name[0].toUpperCase() + (item as ListItem).listType.name.substring(1)} List:\n${item.toYaml()}";
        break;
      default:
        target = "${item.type}:\n${item.toYaml()}";
    }
    final Widget child = ListTile(
      tileColor: item is DividerItem
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).scaffoldBackgroundColor,
      contentPadding: EdgeInsets.all(item is DividerItem ? 8.0 : 24.0),
      title: Text(
        target,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: COLORS.black,
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
        icon: Image.asset(
          ASSETS.remove,
          height: 18.0,
          width: 18.0,
          color: COLORS.black,
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
