import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/base_item.dart";

class QuoteItem extends BaseItem<String> {
  final String quote;
  final String author;

  const QuoteItem({
    this.quote = "",
    this.author = "",
  }) : super(
          title: quote,
          type: "Quote",
          icon: ASSETS.quote,
        );

  @override
  String toYaml() {
    String finalText = quote.replaceAll("\n", "  \n> ");
    String output = "> *\"$finalText\"";
    return author.isNotEmpty ? "$output - $author*" : output;
  }
}
