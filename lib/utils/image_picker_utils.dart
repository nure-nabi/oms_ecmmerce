import 'dart:convert';
import 'dart:io';


import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {

  final ImagePicker _picker = ImagePicker();

 Future<XFile?> cameraCapture()async{
    final XFile? file =await  _picker.pickImage(source: ImageSource.camera);
    if (file!.path.isEmpty) {
      return null;
    }
   await imageFromPath(imagePath: file.path);
    return file;
  }


  Future<XFile?> pickImageFromGallery()async{
    final XFile? file = await  _picker.pickImage(source: ImageSource.gallery);
    if (file!.path.isEmpty) {
      return null;
    }
    String  getPickedImage = await imageFromPath(imagePath: file!.path);
    return file;
  }


  imageFromPath({required String imagePath}) async {

    File file = File(imagePath);
    // Uint8List bytes = file.readAsBytesSync();
    Uint8List bytes = await testCompressFile(file);
    String base64Image = base64Encode(bytes);
    debugPrint("My Base64 image =>  $base64Image");
    return base64Image;
  }

  // compress file and get Uint8List
  Future<Uint8List> testCompressFile(File file) async {
  //  Fluttertoast.showToast(msg: "crop");
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 500,
      minHeight: 500,
      quality: 94,
      rotate: 0,
    );

    return result!;
  }





   urlImageToBase64(String imageUrl) async {
    try {
      // Download the image
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Get the bytes
        final bytes = response.bodyBytes;
        // Convert to Base64
        String base64 = base64Encode(bytes);

        return base64;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error converting image to Base64: $e');
    }
  }

}