import "package:flutter/material.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/widgets/target_box.dart";

import "../../items/base_item.dart";
import "../../items/items.dart";
import "../dialog_done_button.dart";
import "../dialog_form.dart";
import "../tool.dart";

class ListDialog extends StatefulWidget {
  final ListItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const ListDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  final TextEditingController _controller = TextEditingController();
  final List<dynamic> _items = List.empty(growable: true);
  late ListType _currentType;
  bool _isString = true;

  @override
  void initState() {
    super.initState();
    _currentType = widget.item.listType;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void accept({
    required BuildContext context,
    required BaseItem<Object> item,
    required void Function(BaseItem<Object> item) whenAccept,
  }) {
    showDialog(
      context: context,
      builder: (_) => DialogForm(
        item: item,
        whenAccept: whenAccept,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_isString) _itemsPicker(context),
        if (!_isString) const SizedBox(height: 24.0),
        _listTypePicker(),
        const SizedBox(height: 24.0),
        _inputField(context),
        const SizedBox(height: 24.0),
        _buildList(context),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            ListItem(
              items: _items,
              listType: _currentType,
            ),
          );
        }),
      ],
    );
  }

  SizedBox _buildList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          if (_currentType == ListType.task) {
            (dynamic, bool) item = _items[index] as (dynamic, bool);
            return CheckboxListTile(
              value: item.$2,
              onChanged: (value) {
                setState(() {
                  item = (item.$1, !item.$2);
                  _items[index] = item;
                });
              },
              title: Text(
                item.$1 is BaseItem
                    ? "[${(item.$1 as BaseItem).type}] ${(item.$1 as BaseItem).title}"
                    : item.$1.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              secondary: IconButton(
                onPressed: () {
                  setState(() {
                    _items.remove(_items[index]);
                  });
                },
                icon: const Icon(Icons.remove),
              ),
            );
          } else {
            return ListTile(
              title: Text(
                _items[index] is BaseItem
                    ? "[${(_items[index] as BaseItem).type}] ${(_items[index] as BaseItem).title}"
                    : _items[index].toString(),
                overflow: TextOverflow.ellipsis,
              ),
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    _items.remove(_items[index]);
                  });
                },
                icon: const Icon(Icons.remove),
              ),
            );
          }
        },
      ),
    );
  }

  Row _inputField(BuildContext context) {
    return Row(
      children: [
        _isString
            ? Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    label: Text("Item"),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              )
            : Expanded(
                child: TargetBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  verticalMargin: 0,
                  onAccept: (data) {
                    accept(
                      context: context,
                      item: data,
                      whenAccept: (item) {
                        setState(() {
                          if (_currentType == ListType.task) {
                            _items.add((item, false));
                          } else {
                            _items.add(item);
                          }
                          _isString = true;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_currentType == ListType.task) {
                _items.add((_controller.text.trim(), false));
              } else {
                _items.add(_controller.text.trim());
              }

              _controller.clear();
            });
          },
          icon: const Icon(
            Icons.add,
          ),
        ),
        const SizedBox(width: 12.0),
        IconButton(
          onPressed: () {
            setState(() {
              _isString = !_isString;
            });
          },
          icon: const Icon(
            Icons.widgets_rounded,
          ),
        ),
      ],
    );
  }

  SizedBox _itemsPicker(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Tool<InlineCodeItem>(
            item: InlineCodeItem(code: "Inline Code"),
          ),
          const Tool<ImageItem>(
            item: ImageItem(alt: "", path: "Image"),
          ),
          const Tool<LinkItem>(
            item: LinkItem(label: "", link: "Link"),
          ),
          Tool<BadgeItem>(
            item: BadgeItem(
              badge: BadgeType.static,
              inputs: [],
            ),
          )
        ],
      ),
    );
  }

  Widget _listTypePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        ListType.values.length,
        (index) => InkWell(
          onTap: () {
            setState(() {
              _currentType = ListType.values[index];
              _items.clear();
            });
          },
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: _currentType == ListType.values[index]
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Text(
              ListType.values[index].name,
              style: TextStyle(
                color: _currentType == ListType.values[index]
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
