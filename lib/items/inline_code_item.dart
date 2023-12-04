import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";

class InlineCodeItem extends BaseItem<String> {
  final String code;

  const InlineCodeItem({this.code = ""})
      : super(
          title: code,
          type: "Inline Code",
          icon: Icons.code,
        );

  @override
  String toYaml() => "`$code`";
}
