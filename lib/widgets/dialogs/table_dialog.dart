import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/items.dart";

import "../../items/base_item.dart";
import "../dialog_done_button.dart";
import "../dialog_form.dart";
import "../target_box.dart";
import "../tool.dart";

class TableDialog extends StatefulWidget {
  final TableItem item;
  final void Function(BaseItem<Object> item) whenAccept;

  const TableDialog({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  @override
  State<TableDialog> createState() => _TableDialogState();
}

class _TableDialogState extends State<TableDialog> {
  int _rows = 0, _cols = 0;
  final List<dynamic> _items = List.empty(growable: true);
  final TextEditingController _controller = TextEditingController();
  final List<TableAlign> _alignments = List.empty(growable: true);
  bool _isString = true;
  int _currentIndex = 0;

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

  void _fillItems() {
    _currentIndex = 0;
    if (_rows > 1 && _cols > 1) {
      _items.clear();
      _alignments.clear();
      _items.addAll(List.generate(_rows * _cols, (index) => ""));
      _alignments.addAll(List.generate(_cols, (index) => TableAlign.left));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _tableSizeInput(context),
        const SizedBox(height: 24.0),
        if (!_isString) _itemsPicker(context),
        if (!_isString) const SizedBox(height: 24.0),
        _inputField(context),
        const SizedBox(height: 24.0),
        if (_rows > 1 && _cols > 1) _buildTable(context),
        const SizedBox(height: 32.0),
        DialogDoneButton(onPress: () {
          widget.whenAccept(
            TableItem(
              rows: _rows,
              cols: _cols,
              cells: _items,
              alignments: _alignments,
            ),
          );
        }),
      ],
    );
  }

  SizedBox _buildTable(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _alignmentPicker(),
              const SizedBox(height: 24.0),
              Table(
                defaultColumnWidth: FixedColumnWidth(
                  MediaQuery.of(context).size.width * 0.2,
                ),
                children: List.generate(
                  _rows,
                  (index) => TableRow(
                    children: List.generate(
                      _cols,
                      (i) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: _currentIndex == (index * _rows) + i
                                  ? 1.5
                                  : 0.5,
                              color: _currentIndex == (index * _rows) + i
                                  ? COLORS.primary
                                  : COLORS.border,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: _currentIndex > (index * _rows) + i
                              ? ListTile(
                                  title: Text(
                                    _items[(index * _rows) + i] is BaseItem
                                        ? "[${(_items[(index * _rows) + i] as BaseItem).type}] ${(_items[(index * _rows) + i] as BaseItem).title}"
                                        : _items[(index * _rows) + i]
                                            .toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // title: Text("laban"),
                                  leading: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _items.removeAt((index * _rows) + i);
                                        _items.add("");
                                        if (_currentIndex != 0) {
                                          _currentIndex -= 1;
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                )
                              : const SizedBox(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                        _items[_currentIndex] = item;
                        setState(() {
                          _currentIndex += 1;

                          if (_currentIndex == (_rows * _cols) - 1) {
                            return;
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
            _items[_currentIndex] = _controller.text.trim();
            setState(() {
              _currentIndex += 1;
              _controller.clear();

              if (_currentIndex == (_rows * _cols) - 1) {
                return;
              }
              _isString = true;
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

  SizedBox _tableSizeInput(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: _rows.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Rows"),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _rows = int.parse(value);
                    _fillItems();
                  }
                });
              },
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: TextFormField(
              initialValue: _cols.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Columns"),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _cols = int.parse(value);
                    _fillItems();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _alignmentPicker() {
    return Row(
      children: List.generate(
        _cols,
        (i) => SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              TableAlign.values.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _alignments[i] = TableAlign.values[index];
                  });
                },
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: _alignments[i] == TableAlign.values[index]
                        ? Theme.of(context).colorScheme.primaryContainer
                        : COLORS.border,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Center(
                    child: Text(
                      TableAlign.values[index].name.toUpperCase()[0],
                      style: TextStyle(
                        color: _alignments[i] == TableAlign.values[index]
                            ? COLORS.back
                            : Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
