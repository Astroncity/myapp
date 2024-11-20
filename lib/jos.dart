import 'package:flutter/material.dart';

class Jos extends StatelessWidget {
  const Jos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Jos Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
