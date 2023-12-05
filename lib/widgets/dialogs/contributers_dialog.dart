import "package:flutter/material.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class ContributersDialog extends StatefulWidget {
  final ContributersItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const ContributersDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<ContributersDialog> createState() => _ContributersDialogState();
}

class _ContributersDialogState extends State<ContributersDialog> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _repoController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _repoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _userController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("user"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _repoController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("repo"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            ContributersItem(
              user: _userController.text.trim(),
              repo: _repoController.text.trim(),
            ),
          );
        }),
      ],
    );
  }
}
