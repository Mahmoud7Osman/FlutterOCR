part of "main.dart";

Future<String?> _processImage(File imageFile) async {
  final inputImage = InputImage.fromFile(imageFile);
  final textRecognizer = TextRecognizer();
  RecognizedText recognizedText;

  recognizedText = await textRecognizer.processImage(inputImage);

  final String? text = recognizedText.text;

  return text;
}

String? RecognizeText(File? imageFile) {
  String? recognizedText;

  _processImage(imageFile!).then((value) {
    recognizedText = value;
  });
  debugPrint(recognizedText);
  return recognizedText;
}
