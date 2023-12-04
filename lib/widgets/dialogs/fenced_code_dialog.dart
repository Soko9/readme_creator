import "package:flutter/material.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/items.dart";

import "../../constants/constants.dart";
import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class FencedCodeDialog extends StatefulWidget {
  final FencedCodeItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const FencedCodeDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<FencedCodeDialog> createState() => _FencedCodeDialogState();
}

class _FencedCodeDialogState extends State<FencedCodeDialog> {
  final TextEditingController controller = TextEditingController();
  late Languages _currentLanguage;

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.item.language;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            minLines: 1,
            maxLines: 12,
            autofocus: true,
            decoration: const InputDecoration(
              label: Text("Code"),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24.0),
          _languagePicker(),
          const SizedBox(height: 32.0),
          DialogDoneButton(onPress: () {
            widget.whenAccept(
              FencedCodeItem(
                code: controller.text.trim(),
                language: _currentLanguage,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _languagePicker() => Wrap(
        children: List.generate(
          Languages.values.length,
          (index) => InkWell(
            onTap: () {
              setState(() {
                _currentLanguage = Languages.values[index];
              });
            },
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _currentLanguage == Languages.values[index]
                    ? Theme.of(context).colorScheme.primaryContainer
                    : COLORS.border,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(
                Languages.values[index].name,
                style: TextStyle(
                  color: _currentLanguage == Languages.values[index]
                      ? COLORS.back
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
        ),
      );
}
