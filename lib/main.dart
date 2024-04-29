import 'dart:async';
import 'package:blood_sugar/screens/blood_sugar_graph/graph_screen.dart';
import 'package:blood_sugar/theme/font/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runZonedGuarded(() => runApp(const MyApp()), (error, stack) {});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GetMaterialApp(
        title: 'Blood Sugar Graph',
        theme: isDarkMode ? GraphTheme.dark : GraphTheme.light,
        darkTheme: GraphTheme.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const GraphScreen(),
        });
  }
}
