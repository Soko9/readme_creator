import "package:readme_creator/constants/constants.dart";

import "base_item.dart";

class DividerItem extends BaseItem {
  const DividerItem()
      : super(
          title: "",
          type: "Divider",
          icon: ASSETS.divider,
        );

  @override
  String toYaml() => "---";
}
