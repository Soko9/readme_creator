extension StringX on String {
  String get firstPart => split(" ")[0];
  String get secondPartRefined => split(" ")
      .sublist(1)
      .join(" ")
      .replaceAll(" ", "%20")
      .replaceAll("-", "--")
      .replaceAll("_", "__");
  String get replaceNumbersWithSpaces => replaceAll(RegExp(r"(\d+)"), " ");
  String get replaceNumbersWithsymbols =>
      replaceAll("1", "/").replaceAll("2", "-");
  String get replaceSpace => replaceAll(" ", "%20");
}
