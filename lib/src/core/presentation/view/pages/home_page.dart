import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _GameModeButton(
              onPressed: () => _toOfflineGamePage(context),
              label: "Play Offline"),
          _GameModeButton(
              onPressed: () => _toOnlineGamePage(context),
              label: "Play Online"),
        ],
      ),
    );
  }

  void _toOfflineGamePage(BuildContext context) {
    Navigator.pushNamed(context, "offline");
  }

  void _toOnlineGamePage(BuildContext context) {
    Navigator.pushNamed(context, "online");
  }
}

class _GameModeButton extends StatelessWidget {
  const _GameModeButton(
      {super.key, required this.onPressed, required this.label});
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              side: MaterialStatePropertyAll(
                  BorderSide(color: Theme.of(context).primaryColor))),
          child: Text(label),
        ),
      ),
    );
  }
}
