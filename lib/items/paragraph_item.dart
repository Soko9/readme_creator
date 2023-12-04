import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";

class ParagraphItem extends BaseItem<String> {
  final String text;

  const ParagraphItem({this.text = ""})
      : super(
          title: text,
          type: "Paragraph",
          icon: Icons.text_fields_rounded,
        );

  @override
  String toYaml() {
    String finalText = text.replaceAll("\n", "  \n");
    return finalText;
  }
}
