import "package:flutter/material.dart";
import "package:readme_creator/items/base_item.dart";
import "package:readme_creator/items/items.dart";
import "package:readme_creator/widgets/dialogs/dialogs.dart";

class DialogForm extends StatelessWidget {
  final BaseItem<Object> item;
  final void Function(BaseItem<Object> item) whenAccept;

  const DialogForm({
    super.key,
    required this.item,
    required this.whenAccept,
  });

  Widget _getDialogForm() {
    switch (item) {
      case HeaderItem():
        return HeaderDialog(
          item: item as HeaderItem,
          whenAccept: whenAccept,
        );
      case ParagraphItem():
        return ParagraphDialog(
          item: item as ParagraphItem,
          whenAccept: whenAccept,
        );
      case QuoteItem():
        return QuoteDialog(
          item: item as QuoteItem,
          whenAccept: whenAccept,
        );
      case InlineCodeItem():
        return InlineCodeDialog(
          item: item as InlineCodeItem,
          whenAccept: whenAccept,
        );
      case FencedCodeItem():
        return FencedCodeDialog(
          item: item as FencedCodeItem,
          whenAccept: whenAccept,
        );
      case ListItem():
        return ListDialog(
          item: item as ListItem,
          whenAccept: whenAccept,
        );
      case ImageItem():
        return ImgaeDialog(
          item: item as ImageItem,
          whenAccept: whenAccept,
        );
      case LinkItem():
        return LinkDialog(
          item: item as LinkItem,
          whenAccept: whenAccept,
        );
      case TableItem():
        return TableDialog(
          item: item as TableItem,
          whenAccept: whenAccept,
        );
      case BadgeItem():
        return BadgeDialog(
          item: item as BadgeItem,
          whenAccept: whenAccept,
        );
      case ContributersItem():
        return ContributersDialog(
          item: item as ContributersItem,
          whenAccept: whenAccept,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      elevation: 0,
      content: SizedBox(
        width:
            MediaQuery.of(context).size.width * (item is TableItem ? 0.7 : 0.5),
        child: _getDialogForm(),
      ),
    );
  }
}
