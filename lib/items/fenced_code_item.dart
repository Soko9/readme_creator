import "package:flutter/material.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/base_item.dart";

class FencedCodeItem extends BaseItem<String> {
  final String code;
  final Languages language;

  const FencedCodeItem({
    this.code = "",
    this.language = Languages.dart,
  }) : super(
          title: code,
          type: "Fenced Code",
          icon: Icons.code,
        );

  @override
  String toYaml() => "```${language.name}\n$code\n```";
}
