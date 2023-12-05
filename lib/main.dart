import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:readme_creator/constants/constants.dart";
import "package:readme_creator/controllers/canvas_controller.dart";
import "package:readme_creator/screens/main_screen.dart";

// * implement text formatting
// * implement import table from csv/excel

// ? adding random item

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CanvasController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Jetbrains",
          scaffoldBackgroundColor: COLORS.primary.withOpacity(0.05),
          colorScheme: ColorScheme.fromSeed(
            seedColor: COLORS.primary,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
