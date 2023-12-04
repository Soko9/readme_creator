import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";

class ContributersItem extends BaseItem {
  static const String _base = "https://contrib.rocks/image?repo=";

  final String user;
  final String repo;

  const ContributersItem({
    this.user = "",
    this.repo = "",
  }) : super(
          title: repo,
          type: "Contributers",
          icon: Icons.groups,
        );

  @override
  String toYaml() => "![]($_base$user/$repo)";
}
