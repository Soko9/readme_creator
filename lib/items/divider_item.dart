import "package:flutter/material.dart";

import "base_item.dart";

class DividerItem extends BaseItem {
  const DividerItem()
      : super(
          title: "",
          type: "Divider",
          icon: Icons.safety_divider_rounded,
        );

  @override
  String toYaml() => "---";
}
