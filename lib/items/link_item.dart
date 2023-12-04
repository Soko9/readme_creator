import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";

class LinkItem extends BaseItem {
  final String label;
  final String link;

  const LinkItem({
    this.label = "",
    this.link = "",
  }) : super(
          title: link,
          type: "Link",
          icon: Icons.link_rounded,
        );

  @override
  String toYaml() => "[$label]($link)";
}
