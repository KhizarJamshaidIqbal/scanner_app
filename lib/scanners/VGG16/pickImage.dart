// ignore_for_file: file_names, use_super_parameters, avoid_print, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, unused_import, unused_element


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/constants/colors.dart';
import 'package:scanner_app/scanners/VGG16/ResultScreen.dart';
import 'package:scanner_app/widgets/custom_appbar.dart';
import 'package:tflite/tflite.dart';
class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  late String result = '', label = '';
  bool isWorking = false;
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    loadModel();
  }
  
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model/VGG16/VGG16_NewModel.tflite",
        labels: "assets/model/labels.txt",
      );
      print("Model loaded successfully");
    } catch (e) {
      print("Error loading model: $e");
    }
  }
  
  Future<void> runModel(XFile imageFile) async {
    if (!mounted || isWorking) return;
    setState(() {
      isWorking = true;
      isLoading = true;
    });
  
    var recognitions = await Tflite.runModelOnImage(
      path: imageFile.path,
      imageMean: 117,
      imageStd: 1.0,
      numResults: 5,
      threshold: 0.3,
    );
  
    setState(() {
      result = "";
      label = "";
      recognitions?.forEach((response) {
        double confidence = (response["confidence"] as double) * 100;
        print(
            'Raw Confidence: ${(response["confidence"] as double)}, Percentage: $confidence');
        String confidencePercentage = confidence.toStringAsFixed(2);
        result += "\n" +
            "Label :: " +
            response["label"] +
            "\n" +
            "Accuracy :: " +
            "$confidencePercentage%" +
            "\n";
        label += response["label"];
      });
      isWorking = false;
      isLoading = false;
      // Navigate to the ResultScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(File(imageFile.path), result, label),
        ),
      );
    });
  }
  
  Future<void> _openCamera() async {
    try {
      final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      runModel(pickedFile);
      print('Camera Open Sucessfully');
    }
    } catch (e) {
      print(e);
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    Tflite.close();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: globalColors.primaryGradient,
        ),
        child: InkWell(
          onTap: () {
            _openCamera();
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned( 
                top: 10, left: 0, right: 0,
                child: Center(
                  child: Lottie.asset(
                    'assets/images/scanner_2.json',
                  ),
                ),
              ),
              isLoading
                  ? Positioned.fill(
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    )
                  :
              Center(
                      child: Text(
                        'Select the Image from Camera',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: globalColors.WhiteColor,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
