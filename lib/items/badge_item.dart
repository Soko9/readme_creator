import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/extensions/extensions.dart";
import "package:readme_creator/items/base_item.dart";

class BadgeItem extends BaseItem {
  static const String _base = "https://img.shields.io/";
  final String label;
  final List<String> inputs;
  final BadgeType badge;
  final String color;
  final String link;

  BadgeItem({
    this.badge = BadgeType.static,
    this.inputs = const [],
    this.color = "",
    this.label = "",
    this.link = "",
  }) : super(
          title: badge.name.replaceNumbersWithSpaces,
          type: "Badge",
          icon: ASSETS.badge,
        );

  @override
  String toYaml() {
    String url = "";
    for (String str in inputs) {
      url += "/$str";
    }
    String output = badge == BadgeType.static
        ? "![](${_base}badge/${label.firstPart}-${label.secondPartRefined}-${color.isEmpty ? "blue" : color})"
        : "![]($_base${badge.name.replaceNumbersWithsymbols}$url?color=${color.isEmpty ? "blue" : color}${badge.logo == null ? "" : "&logo=${badge.logo}"}${label.isEmpty ? "" : "&label=${label.replaceSpace}"})";

    return link.isEmpty ? output : "<a href=\"$link\">$output<a/>";
  }
}
