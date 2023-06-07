import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';
import 'dart:math' as math;

class PoseNet extends StatefulWidget {
  final List<CameraDescription> cameras;

  const PoseNet(this.cameras);

  @override
  State<PoseNet> createState() => _PoseNetState();
}

class _PoseNetState extends State<PoseNet> {
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool loaded = false;

  List<dynamic> _recognitions = [];
  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {
        loaded = true;
      });
    });
  }
  loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");


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
    Size screen = MediaQuery.of(context).size;
    if (!loaded) {
      return Container(child: Text("Model loading, please wait"));
    }
    return Scaffold(
      body: Stack(
        children: [
          Camera(widget.cameras, "posenet", setRecognitions),
          _recognitions.length > 0
              ?  BndBox(
              _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width, "posenet")
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
