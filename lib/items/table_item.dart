import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/enums/enums.dart";
import "package:readme_creator/items/base_item.dart";

class TableItem extends BaseItem {
  final int rows;
  final int cols;
  final List<dynamic> cells;
  final List<TableAlign> alignments;

  const TableItem({
    this.rows = 0,
    this.cols = 0,
    this.cells = const [],
    this.alignments = const [],
  }) : super(
          title: "[$rows x $cols]",
          type: "Table",
          icon: ASSETS.table,
        );

  @override
  String toYaml() {
    String output = "|";
    final List<dynamic> header = [];
    final List<List<dynamic>> rows = [];

    header.addAll(cells.sublist(0, cols));

    for (int i = cols; i < cells.length; i += cols) {
      rows.add(
        cells.sublist(
          i,
          i + cols > cells.length ? cells.length : i + cols,
        ),
      );
    }

    // creating head
    for (dynamic head in header) {
      output += "${head is BaseItem ? head.toYaml() : head} |";
    }
    output += "\n|";

    // creating header border with alignment
    for (int i = 0; i < cols; i++) {
      switch (alignments[i]) {
        case TableAlign.left:
          output += ":----|";
        case TableAlign.center:
          output += ":----:|";
        case TableAlign.right:
          output += "----:|";
      }
    }
    output += "\n";

    // creating body
    for (List<dynamic> row in rows) {
      output += "|";
      for (dynamic r in row) {
        output += "${r is BaseItem ? r.toYaml() : r}|";
      }
      output += "\n";
    }

    return output;
  }
}
