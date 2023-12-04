import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/items.dart";
import "package:readme_creator/widgets/dialog_done_button.dart";

import "../../items/base_item.dart";

class HeaderDialog extends StatefulWidget {
  final HeaderItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const HeaderDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<HeaderDialog> createState() => _HeaderDialogState();
}

class _HeaderDialogState extends State<HeaderDialog> {
  final TextEditingController _controller = TextEditingController();
  late Headers _currentHeader;

  @override
  void initState() {
    super.initState();
    _currentHeader = widget.item.header;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Header"),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        _headerPicker(),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            HeaderItem(
              text: _controller.text.trim(),
              header: _currentHeader,
            ),
          );
        }),
      ],
    );
  }

  Widget _headerPicker() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          Headers.values.length,
          (index) => InkWell(
            onTap: () {
              setState(() {
                _currentHeader = Headers.values[index];
              });
            },
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: _currentHeader == Headers.values[index]
                    ? Theme.of(context).colorScheme.primaryContainer
                    : COLORS.border,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: _currentHeader == Headers.values[index]
                        ? COLORS.back
                        : Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
