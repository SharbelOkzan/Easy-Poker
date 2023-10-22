import 'package:flutter/material.dart';

class WaitingForPlayersWidget extends StatelessWidget {
  const WaitingForPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.people),
        SizedBox(height: 4),
        CircularProgressIndicator(),
        SizedBox(height: 8),
        Text("Waiting for another player to join"),
      ],
    );
  }
}
