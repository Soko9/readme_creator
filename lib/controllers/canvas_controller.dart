import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";

class CanvasController extends ChangeNotifier {
  final List<BaseItem> _items = List.empty(growable: true);

  List<BaseItem> get items => _items;

  void addItem({required BaseItem item}) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem({required BaseItem item}) {
    _items.remove(item);
    notifyListeners();
  }

  void insertItemAt({required int index, required BaseItem item}) {
    _items.insert(index, item);
    notifyListeners();
  }

  BaseItem removeItemAt({required int index}) {
    return _items.removeAt(index);
  }

  String releaseYaml() {
    String yaml = "";
    for (BaseItem item in items) {
      yaml += "${item.toYaml()}\n\n";
    }
    return yaml;
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}
