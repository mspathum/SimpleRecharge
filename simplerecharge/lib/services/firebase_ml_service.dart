import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FirebaseMLService {
  static Future<String> recogniseText(File imageFile) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    try {
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);
      await textRecognizer.close();

      final text = extractText(visionText);
      return text.isEmpty ? "No text found" : text;
    } catch (err) {
      print("Error--" + err.toString());
      return err.toString();
    }
  }

  static extractText(VisionText visionText) {
    String text = "";

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          text = text + word.text.toString() + '';
        }
        text = text + '\n';
      }
    }
    return text;
  }
}
