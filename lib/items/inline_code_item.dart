import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/base_item.dart";

class InlineCodeItem extends BaseItem<String> {
  final String code;

  const InlineCodeItem({this.code = ""})
      : super(
          title: code,
          type: "Inline Code",
          icon: ASSETS.inlineCode,
        );

  @override
  String toYaml() => "`$code`";
}
