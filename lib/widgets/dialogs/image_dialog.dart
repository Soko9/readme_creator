import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class ImgaeDialog extends StatefulWidget {
  final ImageItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const ImgaeDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<ImgaeDialog> createState() => _ImgaeDialogState();
}

class _ImgaeDialogState extends State<ImgaeDialog> {
  final TextEditingController _altController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    _altController.dispose();
    _pathController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _altController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Alt Text"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _pathController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Path"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _linkController,
          decoration: const InputDecoration(
            label: Text("Full Link (optional)"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            ImageItem(
              alt: _altController.text.trim(),
              path: _pathController.text.trim(),
              link: _linkController.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
