
import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:fluttershowcasev1/posenet.dart';
import 'package:fluttershowcasev1/segmentation.ts.dart';

import 'ImageClassification.dart';


class Home extends StatefulWidget {
  late final List<CameraDescription> cameras;

  Home(this.cameras);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        title: Text('DS Show Case App'),
        backgroundColor: Colors.redAccent,
      ),
      body:
      Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Segmentation(),
                          fullscreenDialog: true
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.

                      ));
                },
                child: const Text('Segmentation'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ImageClassification(widget.cameras),
                          fullscreenDialog: true
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.

                      ));
                },
                child: const Text('Mobile Net Image Classification'),
              )
              ,TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  PoseNet(widget.cameras),
                          fullscreenDialog: true
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.

                      ));
                },
                child: Text('Posenet'),
              )

            ],
          ),
        ),
      ),
    );
  }
}
