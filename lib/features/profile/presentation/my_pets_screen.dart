// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = ["Luna (Cat)", "Rocky (Dog)"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My pets"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go("/profile/pets/add-step1"),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: pets.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(title: Text(pets[index]));
        },
      ),
    );
  }
}
