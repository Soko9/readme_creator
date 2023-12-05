import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/base_item.dart";

class ParagraphItem extends BaseItem<String> {
  final String text;

  const ParagraphItem({this.text = ""})
      : super(
          title: text,
          type: "Text",
          icon: ASSETS.text,
        );

  @override
  String toYaml() {
    String finalText = text.replaceAll("\n", "  \n");
    return finalText;
  }
}
