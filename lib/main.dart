import 'package:easy_poker/firebase_options.dart';
import 'package:easy_poker/src/core/presentation/theme/main_theme.dart';
import 'package:easy_poker/src/core/presentation/view/pages/offline_game_page.dart';
import 'package:easy_poker/src/core/presentation/view/pages/home_page.dart';
import 'package:easy_poker/src/core/presentation/view/pages/online_game_page.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: defaultTheme,
        onGenerateRoute: _onGenerateRoute,
        home: const Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'online':
        return MaterialPageRoute(builder: (_) => const OnlineGamePage());
      case 'offline':
        return MaterialPageRoute(builder: (_) => const OfflineGamePage());
    }
    return null;
  }
}
