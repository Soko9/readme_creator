import "package:flutter/material.dart";

abstract class BaseItem<T extends Object> {
  final String title;
  final String _type;
  final IconData icon;

  const BaseItem({
    required this.title,
    required String type,
    required this.icon,
  }) : _type = type;

  String toYaml();

  String get type => _type;
}
