import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class ParagraphDialog extends StatefulWidget {
  final ParagraphItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const ParagraphDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<ParagraphDialog> createState() => _ParagraphDialogState();
}

class _ParagraphDialogState extends State<ParagraphDialog> {
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
          maxLines: 6,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Paragraph"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            ParagraphItem(
              text: controller.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
