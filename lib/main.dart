import 'package:flutter/material.dart';
import 'package:reminder_app/controoler/theme_controller.dart';
import 'package:reminder_app/view/pages/home_pages.dart';
import 'package:provider/provider.dart';

import 'golbes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: Themes.ligth,
          darkTheme: Themes.drak,
          themeMode: (Provider.of<ThemeController>(context).themeModel.isdark)?ThemeMode.dark:ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}
