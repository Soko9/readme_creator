import "package:flutter/material.dart";
import "package:readme_creator/constants/colors.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";

class BadgeDialog extends StatefulWidget {
  final BadgeItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const BadgeDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<BadgeDialog> createState() => _BadgeDialogState();
}

class _BadgeDialogState extends State<BadgeDialog> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final List<TextEditingController> _controllers = List.empty(growable: true);
  final List<Widget> _inputs = List.empty(growable: true);
  BadgeType _badge = BadgeType.static;
  String _search = "";

  @override
  void dispose() {
    _labelController.dispose();
    _colorController.dispose();
    _linkController.dispose();
    for (TextEditingController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _search = value;
            });
          },
          decoration: const InputDecoration(
            hintText: "seach badges",
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24.0),
        _badgePicker(_search.isEmpty
            ? BadgeType.values
            : BadgeType.values
                .where((element) => element.name.startsWith(_search))
                .toList()),
        const SizedBox(height: 24.0),
        _badgeWidgets(_badge),
        const SizedBox(height: 24.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _labelController,
                decoration: const InputDecoration(
                  label: Text("Label"),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: TextField(
                controller: _colorController,
                decoration: const InputDecoration(
                  label: Text("CSS Color or Hex Code"),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ],
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
            BadgeItem(
              badge: _badge,
              inputs: _controllers
                  .map((controller) => controller.text.trim())
                  .toList(),
              label: _labelController.text.trim(),
              color: _colorController.text.trim().replaceAll("#", ""),
              link: _linkController.text.trim(),
            ),
          );
        }),
      ],
    );
  }

  Widget _badgePicker(List<BadgeType> badges) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: badges
                .map(
                  (badge) => InkWell(
                    onTap: () {
                      setState(() {
                        _controllers.clear();
                        _inputs.clear();
                        _badge = badge;
                      });
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _badge == badge
                            ? Theme.of(context).colorScheme.primaryContainer
                            : COLORS.border,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        badge.name.replaceAll(RegExp(r"(\d+)"), " "),
                        style: const TextStyle(
                          color: COLORS.back,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget _badgeWidgets(BadgeType badge) {
    for (String str in badge.params) {
      final TextEditingController controller = TextEditingController();
      final Widget field = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            label: Text(str),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
          ),
        ),
      );

      setState(() {
        _controllers.add(controller);
        _inputs.add(field);
      });
    }
    return Column(
      children: _inputs,
    );
  }
}
