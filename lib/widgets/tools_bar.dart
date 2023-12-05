import "package:flutter/material.dart";
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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            width: 2.0,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 24.0),
              const Text(
                "primitives",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
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
              ),
              const SizedBox(height: 24.0),
              const Text(
                "containers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  children: [
                    Tool<ListItem>(
                      item: ListItem(),
                    ),
                    const Tool<TableItem>(
                      item: TableItem(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                "dynamic",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  children: [
                    Tool<BadgeItem>(
                      item: BadgeItem(),
                    ),
                    const Tool<ContributersItem>(
                      item: ContributersItem(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                "other",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  children: const [
                    Tool<DividerItem>(item: DividerItem()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
