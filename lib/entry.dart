import 'package:flutter/material.dart';
import 'model.dart';

class EntryScreen extends StatelessWidget {
  final JournalEntry entry;

  const EntryScreen({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            entry.imagePath.isNotEmpty
                ? Image.asset(entry.imagePath, height: 200, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 200),
            const SizedBox(height: 16),
            Text(entry.notes),
          ],
        ),
      ),
    );
  }
}
