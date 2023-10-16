import 'package:easy_poker/src/core/presentation/view/pages/game_page.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: GamePage(),
        ),
      ),
    );
  }
}
