import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';

class ImageClassification extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ImageClassification(this.cameras);

  @override
  State<ImageClassification> createState() => _ImageClassificationState();
}

class _ImageClassificationState extends State<ImageClassification> {
  bool loaded = false;
  int _imageHeight = 0;
  int _imageWidth = 0;

  @override
  void initState() {
    // TODO: implement initState
    loadModel();

    super.initState();
  }

  List<dynamic> _recognitions = [];


  loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
    setState(() {
      loaded = true;
    });
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screen = MediaQuery.of(context).size;
    if (!loaded) {
      return Container(child: Text("Model loading, please wait"));
    }
    return Scaffold(
      body: Stack(
        children: [
          Camera(widget.cameras, "", setRecognitions),
          _recognitions.length > 0
              ? BndBox(
                  _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width, "ssd")
              : Container(child: Text("Nothing to predict"))
        ],
      ),
      // https://m3.material.io/components/floating-action-button/specs
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
