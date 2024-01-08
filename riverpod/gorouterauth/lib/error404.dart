import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('404 page not found'),
            ElevatedButton(onPressed: () => context.go('/'), child: const Text('Go to home')),
          ],
        ),
      ),
    );
  }
}
