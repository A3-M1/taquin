import 'dart:io';
import 'dart:typed_data'; // Pour gérer les fichiers en mémoire (web)
import 'package:flutter/foundation.dart'; // Pour vérifier si on est sur Web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; // Pour choisir une image sur Web

class Exo0 extends StatefulWidget {
  const Exo0({super.key});

  @override
  State<Exo0> createState() => _Exo0State();
}

class _Exo0State extends State<Exo0> {
  Uint8List? _webImage;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  pickImageFromGallery() async {
    if (kIsWeb) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _webImage = result.files.first.bytes;
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  pickImageFromCamera() async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera not supported on Web!")),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exo0'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _webImage != null
                ? Image.memory(_webImage!,
                    width: 300, height: 300, fit: BoxFit.cover)
                : _image != null
                    ? Image.file(_image!,
                        width: 300, height: 300, fit: BoxFit.cover)
                    : const Text('No image picked.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImageFromCamera,
              child: const Text('Take Photo with Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
