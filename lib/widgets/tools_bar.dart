import "package:flutter/material.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/items/items.dart";

import "tool.dart";

class ToolsBar extends StatelessWidget {
  const ToolsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      height: size.height,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 2.0,
            color: COLORS.border,
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            const Text(
              "Primitives",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: const [
                Tool<HeaderItem>(
                  item: HeaderItem(),
                ),
                Tool<ParagraphItem>(
                  item: ParagraphItem(),
                ),
                Tool<InlineCodeItem>(
                  item: InlineCodeItem(),
                ),
                Tool<FencedCodeItem>(
                  item: FencedCodeItem(),
                ),
                Tool<ImageItem>(
                  item: ImageItem(),
                ),
                Tool<LinkItem>(
                  item: LinkItem(),
                ),
                Tool<QuoteItem>(
                  item: QuoteItem(),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Divider(color: COLORS.border.withOpacity(0.75)),
            const Text(
              "Containers",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Tool<ListItem>(
                  item: ListItem(),
                ),
                const Tool<TableItem>(
                  item: TableItem(),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Divider(color: COLORS.border.withOpacity(0.75)),
            const Text(
              "Dynamic",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Tool<BadgeItem>(
                  item: BadgeItem(),
                ),
                const Tool<ContributersItem>(
                  item: ContributersItem(),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Divider(color: COLORS.border.withOpacity(0.75)),
            const Text(
              "Other",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: const [
                Tool<DividerItem>(item: DividerItem()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
