import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/base_item.dart";

class HeaderItem extends BaseItem<String> {
  final String text;
  final Headers header;

  const HeaderItem({
    this.text = "",
    this.header = Headers.h1,
  }) : super(
          title: text,
          type: "Header",
          icon: ASSETS.header,
        );

  @override
  String toYaml() => "${header.hash} $text";
}
