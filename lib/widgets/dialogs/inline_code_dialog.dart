import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class InlineCodeDialog extends StatefulWidget {
  final InlineCodeItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const InlineCodeDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<InlineCodeDialog> createState() => _InlineCodeDialogState();
}

class _InlineCodeDialogState extends State<InlineCodeDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          minLines: 1,
          maxLines: 1,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Code"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            InlineCodeItem(
              code: controller.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
