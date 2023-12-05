import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class LinkDialog extends StatefulWidget {
  final LinkItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const LinkDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _labelController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Label"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _linkController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Full Link"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            LinkItem(
              label: _labelController.text.trim(),
              link: _linkController.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
