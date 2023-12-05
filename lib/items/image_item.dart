import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/base_item.dart";

class ImageItem extends BaseItem {
  final String alt;
  final String path;
  final String link;

  const ImageItem({
    this.alt = "",
    this.path = "",
    this.link = "",
  }) : super(
          title: path,
          type: "Image",
          icon: ASSETS.image,
        );

  @override
  String toYaml() {
    String output = "![$alt]($path)";
    return link.isNotEmpty ? "<a href=\"$link\">$output</a>" : output;
  }
}
