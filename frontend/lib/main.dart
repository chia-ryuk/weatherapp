import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';

/// Entry point of the Flutter application.
/// This function initializes and runs the Flutter application by creating an instance of the [MyApp] class.
void main() {
  runApp(const MyApp());
}

/// The root widget of the Flutter application.
/// The [MyApp] class extends [StatelessWidget] and is responsible for setting up the main configuration for the application, including the title, theme, and home page.

class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  /// The [super.key] parameter is passed to the [StatelessWidget] constructor.
  const MyApp({super.key});

  /// Builds the [MaterialApp] widget for the application.
  ///
  /// This method returns a [MaterialApp] widget with the following properties:
  /// - `title`: The title of the application, set to 'Flutter Weather App'.
  /// - `debugShowCheckedModeBanner`: A boolean flag to show or hide the debug banner,
  ///   set to `false` to hide the banner.
  /// - `theme`: The theme of the application, created using [ThemeData] and a color
  ///   scheme based on a seed color.
  /// - `home`: The home page of the application, set to an instance of [Homepage].
  ///
  /// The theme uses Material 3 design principles, enabled by the `useMaterial3` property.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}
