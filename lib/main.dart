import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(TravelJournalApp());

class TravelJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JournalEntryScreen(),
    );
  }
}

class JournalEntryScreen extends StatefulWidget {
  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  void _saveEntry() {
    if (_titleController.text.isEmpty || _noteController.text.isEmpty || _image == null) {
      // Show an alert dialog if any field is empty
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please provide a title, note, and select an image.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    //  data 

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Entry Saved!'),
    ));

    _titleController.clear();
    _noteController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              child: Text('Pick Image'),
              onPressed: _pickImage,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save Entry'),
              onPressed: _saveEntry,
            ),
          ],
        ),
      ),
    );
  }
}
