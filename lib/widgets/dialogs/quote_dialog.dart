import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class QuoteDialog extends StatefulWidget {
  final QuoteItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const QuoteDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<QuoteDialog> createState() => _QuoteDialogState();
}

class _QuoteDialogState extends State<QuoteDialog> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  void dispose() {
    _quoteController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _quoteController,
          minLines: 1,
          maxLines: 6,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Quote"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _authorController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Author (optional)"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            QuoteItem(
              quote: _quoteController.text.trim().replaceAll("\"", ""),
              author: _authorController.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
