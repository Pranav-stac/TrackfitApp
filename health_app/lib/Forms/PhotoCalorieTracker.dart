import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: ImagePickerPage(),
  ));
}

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker and Upload'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickAndUploadImage(ImageSource.camera),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Pick from Camera'),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _pickAndUploadImage(ImageSource.gallery),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('Pick from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    try {
      _image = await _picker.pickImage(source: source);
      if (_image != null) {
        // Once image is picked, upload it
        await uploadComplaint( _image!.path);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadComplaint(String imagePath) async {
    final Uri apiUrl = Uri.parse('https://stable-simply-porpoise.ngrok-free.app/analyze_image/'); // Update with your Django server URL

    var request = http.MultipartRequest('POST', apiUrl);
    // Attach image file
    if (imagePath.isNotEmpty) {
      var imageFile = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(imageFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        // Read the response body
        var responseBody = await http.Response.fromStream(response);
        print('Image uploaded successfully. Response: ${responseBody.body}');
      } else {
        print('Failed to upload: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading complaint: $e');
    }
  }
}
