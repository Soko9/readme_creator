// ignore_for_file: avoid_web_libraries_in_flutter

import "dart:convert";
import "dart:html" as html;

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/controllers/canvas_controller.dart";
import "package:readme_creator/widgets/canvas_sheet.dart";
import "package:readme_creator/widgets/tools_bar.dart";
import "package:url_launcher/url_launcher.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String yaml = "";
  bool isLoading = false;

  void yamlPressed({required BuildContext context}) {
    setState(() {
      yaml =
          Provider.of<CanvasController>(context, listen: false).releaseYaml();
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.height * 0.8,
                    child: TextFormField(
                      initialValue: yaml,
                      minLines: null,
                      maxLines: null,
                      expands: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          yaml = value;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: COLORS.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          FilledButton.tonal(
            onPressed: () async {
              Navigator.pop(context);
              await saveFile();
            },
            child: const Text("export as .md file"),
          ),
        ],
      ),
    );
  }

  Future<void> saveFile() async {
    setState(() {
      isLoading = true;
    });

    final List<int> bytes = utf8.encode(yaml);
    final html.Blob blob = html.Blob([bytes]);
    final String url = html.Url.createObjectUrlFromBlob(blob);
    final html.AnchorElement anchor =
        html.document.createElement("a") as html.AnchorElement
          ..href = url
          ..style.display = "none"
          ..download = "README.md";

    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    setState(() {
      isLoading = false;
    });
  }

  void clearCanvas({required BuildContext context}) {
    Provider.of<CanvasController>(context, listen: false).clearItems();
  }

  void infoPressed() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "*> There are 4 types of elements you can deal with: [primitives, containers, dynamic & other].\nAll you need to do is drag the item you want to the canvas target and fill out the needed info in the pop up dialog.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: COLORS.primary,
                  ),
                ),
                const SizedBox(height: 48.0),
                const Text(
                  "*> All the items inside the canvas are reorderable.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: COLORS.primary,
                  ),
                ),
                const SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Center(
                        child: FloatingActionButton(
                          onPressed: () => clearCanvas(context: context),
                          elevation: 0,
                          backgroundColor: COLORS.primary,
                          hoverElevation: 0,
                          child: const Icon(
                            Icons.clear_all_rounded,
                            color: COLORS.back,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    const Expanded(
                      child: Text(
                        "This button will clear all the elemnts from the canvas.",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Center(
                        child: FloatingActionButton(
                          onPressed: () => yamlPressed(context: context),
                          elevation: 0,
                          backgroundColor: COLORS.primary,
                          hoverElevation: 0,
                          child: const Icon(
                            Icons.expand_more_outlined,
                            color: COLORS.back,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    const Expanded(
                      child: Text(
                        "If canvas is empty, this will open a dialog\nwith empty space to write what ever you want (hopefully markdown text),\nif canvas has items, it will open a dialog\nwith all the items converted to markdown text, editable of course.",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: FilledButton.tonal(
                        onPressed: () {},
                        child: const Text("export as .md file"),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    const Expanded(
                      child: Text(
                        "This button inside pop up dialog will export the text\nand save it as README.md file in your preffered directory.",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void repoPressed() async {
    final Uri url = Uri.parse("https://github.com/Soko9/readme_creator");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: repoPressed,
                  child: const Text(
                    "visit repo",
                    style: TextStyle(
                      fontSize: 18.0,
                      decoration: TextDecoration.underline,
                      decorationColor: COLORS.primary,
                      fontWeight: FontWeight.w200,
                      color: COLORS.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 24.0),
                IconButton(
                  onPressed: infoPressed,
                  icon: const Icon(
                    Icons.info,
                    color: COLORS.primary,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                const Row(
                  children: [
                    ToolsBar(),
                    CanvasSheet(),
                  ],
                ),
                Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: () => clearCanvas(context: context),
                        elevation: 0,
                        backgroundColor: COLORS.primary.withOpacity(0.7),
                        hoverElevation: 0,
                        child: const Icon(
                          Icons.clear_all_rounded,
                          color: COLORS.back,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      FloatingActionButton(
                        onPressed: () => yamlPressed(context: context),
                        elevation: 0,
                        backgroundColor: COLORS.primary.withOpacity(0.7),
                        hoverElevation: 0,
                        child: const Icon(
                          Icons.expand_more_outlined,
                          color: COLORS.back,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
