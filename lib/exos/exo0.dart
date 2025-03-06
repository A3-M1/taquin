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
  String? _randomImageUrl;
  final ImagePicker _picker = ImagePicker();

  pickImageFromGallery() async {
    if (kIsWeb) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _webImage = result.files.first.bytes;
          _randomImageUrl = null;
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _randomImageUrl = null;
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
        _randomImageUrl = null;
      });
    }
  }

  pickRandomImage() {
    setState(() {
      _webImage = null;
      _image = null;
      _randomImageUrl =
          'https://picsum.photos/300/300?random=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) => FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRect(
                    child: Align(
                      alignment:
                          Alignment(index % 3 - 1, (index / 3).toInt() - 1),
                      widthFactor: 1 / 3,
                      heightFactor: 1 / 3,
                      child: _webImage != null
                          ? Image.memory(_webImage!,
                              width: 300, height: 300, fit: BoxFit.cover)
                          : _image != null
                              ? Image.file(_image!,
                                  width: 300, height: 300, fit: BoxFit.cover)
                              : _randomImageUrl != null
                                  ? Image.network(_randomImageUrl!,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover)
                                  : const Text('No image picked.'),
                    ),
                  ),
                ),
              ),
            ),
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickRandomImage,
              child: const Text('Pick a image randomly'),
            ),
          ],
        ),
      ),
    );
  }
}
