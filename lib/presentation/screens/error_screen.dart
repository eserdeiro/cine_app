import 'package:cine_app/config/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not found'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(Strings.homeUrl),
          child: const Text('Go to home page'),
        ),
      ),
    );
  }
}
