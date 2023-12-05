import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/base_item.dart";

class ListItem extends BaseItem {
  final List<dynamic> items;
  final ListType listType;

  ListItem({
    this.items = const [],
    this.listType = ListType.ordered,
  }) : super(
          title: "List",
          type: "List",
          icon: ASSETS.list,
        );

  @override
  String toYaml() => listType == ListType.unordered
      ? items
          .map((item) => "- ${item is BaseItem ? (item).toYaml() : item}\n")
          .toList()
          .join()
      : listType == ListType.ordered
          ? items
              .map((item) =>
                  "${items.indexOf(item) + 1}. ${item is BaseItem ? (item).toYaml() : item}\n")
              .toList()
              .join()
          : items
              .map((item) =>
                  "- [${(item).$2 ? "x" : " "}] ${item.$1 is BaseItem ? (item.$1 as BaseItem).toYaml() : item.$1}\n")
              .toList()
              .join();
}
