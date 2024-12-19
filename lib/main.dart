import "dart:io";
import "package:file_selector/file_selector.dart";
import "package:flutter/material.dart";
import "package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart";

part "ocr_tool.dart";

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Optical Character Recognition"),
          ),
          body: PickImage()),
    );
  }
}

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  String? text;

  Future<void> _selectImage() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: [
        const XTypeGroup(label: 'Images', extensions: ['jpg', 'png', 'jpeg'])
      ],
    );

    if (file != null) {
      setState(() {
        _imageFile = File(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        () {
          if (_imageFile == null) {
            return const Text("No Image Selected");
          } else {
            text = RecognizeText(_imageFile!);

            return Image.file(
              _imageFile!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            );
          }
        }(),
        ElevatedButton(
            onPressed: _selectImage, child: const Text("Select an Image")),
        Container(
          child: Text(text == null ? "!- No Text Detected -!" : text!),
        ),
      ],
    );
  }
}
