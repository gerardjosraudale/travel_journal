import 'package:flutter/material.dart';
import 'add_entry.dart';
import 'model.dart';
import 'entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<JournalEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Journal'),
      ),
      body: entries.isEmpty
          ? const Center(child: Text("No journal entries yet."))
          : JournalEntriesList(entries: entries),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEntry = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          );
          if (newEntry != null) {
            setState(() {
              entries.add(newEntry);
            });
          }
        },
        tooltip: 'Add Journal Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class JournalEntriesList extends StatelessWidget {
  final List<JournalEntry> entries;

  const JournalEntriesList({required this.entries, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: entries[index].imagePath.isNotEmpty
              ? Image.asset(entries[index].imagePath, width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.image),
          title: Text(entries[index].title),
          subtitle: Text(entries[index].notes),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EntryScreen(entry: entries[index]),
              ),
            );
          },
        );
      },
    );
  }
}
