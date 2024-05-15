import 'package:camera/camera.dart';
import 'package:dash_maze_runner/controller/pytorch_lite_helper.dart';
//import 'package:dash_maze_runner/controller/flutter_vision_helper.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionView extends StatefulWidget {
  const DetectionView({super.key});

  @override
  State<DetectionView> createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  @override
  void initState() {
    super.initState();
    initDetectionScreen();
  }

  Future<void> initDetectionScreen() async {
    /* Uncomment if you are using the FlutterVisionHelper */
    // final visionHelper =
    //     Provider.of<FlutterVisionHelper>(context, listen: false);
    /* Uncomment if you are using the PytorchLiteHelper */
    final visionHelper = Provider.of<PytorchLiteHelper>(context, listen: false);
    await visionHelper.initVision().then((errorText) {
      if (errorText != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorText)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vision initialized succesfully")));
      }
    }).then((_) {});
    setState(() {});
  }

  @override
  void deactivate() async {
    super.deactivate();
    /* Uncomment if you are using the FlutterVisionHelper */
    // final visionHelper =
    //     Provider.of<FlutterVisionHelper>(context, listen: false);
    /* Uncomment if you are using the PytorchLiteHelper */
    final visionHelper = Provider.of<PytorchLiteHelper>(context, listen: false);
    visionHelper.closeVision();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    /* Uncomment if you are using the FlutterVisionHelper */
    // final visionHelper =
    //     Provider.of<FlutterVisionHelper>(context, listen: false);
    /* Uncomment if you are using the PytorchLiteHelper */
    final visionHelper = Provider.of<PytorchLiteHelper>(context, listen: false);
    bool boxesFlipped = false;
    if (visionHelper.yoloResults.isEmpty) return [];
    // First, we need to aquire the image width and height. This is not
    // necissarily width and height of the shown image. If we are in portrait
    // mode, the width and height of the image can be swapped depending on the
    // device. (the image from the camerastream is not the same as the screen
    // size and aspect ratio of the cameraPreview widget). Since the app is
    // locked to portrait mode, we can assume that the width is always smaller
    // than the height. So if the image height is smaller than the width, we
    // swap these properties.
    var imageWidth = visionHelper.cameraImage?.width ?? 1;
    var imageHeight = visionHelper.cameraImage?.height ?? 1;
    if (imageHeight < imageWidth) {
      var temp = imageHeight;
      imageHeight = imageWidth;
      imageWidth = temp;
      boxesFlipped = true;
    }

    // Next, we need to calculate the factor by which we need to multiply the
    // bounding box coordinates to get the correct position on the screen.
    var factorX = screen.width / imageWidth;
    var factorY = (screen.width *
            visionHelper.cameraHelper.cameraController.value.aspectRatio) /
        imageHeight;

    // Now we can create the bounding boxes.
    var boundingBoxes = <Widget>[];
    /* Uncomment if you are using the FlutterVisionHelper */
    //   for (var result in controller.yoloResults) {
    //     boundingBoxes.add(Positioned(
    //       left: result["box"][0] * factorX,
    //       top: result["box"][1] * factorY,
    //       width: (result["box"][2] - result["box"][0]) * factorX,
    //       height: (result["box"][3] - result["box"][1]) * factorY,
    //       child: Container(
    //           decoration: BoxDecoration(
    //             border: Border.all(color: buttonBackgroundColor, width: 2.0),
    //           ),
    //           child: null),
    //     ));
    //   }
    for (var result in visionHelper.yoloResults) {
      boundingBoxes.add(Positioned(
        left: boxesFlipped ? result.rect.left * factorX * imageWidth : (1 - result.rect.bottom) * factorX * imageWidth,
        top: boxesFlipped ? result.rect.top * factorY * imageHeight : result.rect.left * factorY * imageHeight,
        width: boxesFlipped ? result.rect.width * factorX * imageWidth : result.rect.height * factorX * imageWidth,
        height: boxesFlipped ? result.rect.height * factorY * imageHeight : result.rect.width * factorY * imageHeight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonBackgroundColor, width: 2.0),
          ),
        ),
      ));
    }
    return boundingBoxes;
  }

  @override
  Widget build(BuildContext context) {
    /* Uncomment if you are using the FlutterVisionHelper */
    // final visionHelper = Provider.of<FlutterVisionHelper>(context);
    /* Uncomment if you are using the FlutterVisionHelper */
    final visionHelper = Provider.of<PytorchLiteHelper>(context);
    final size = MediaQuery.of(context).size;
    return visionHelper.isVisionInitialized && visionHelper.hasDetectionStarted
        ? Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
                //color: greenBackground,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child:
                    CameraPreview(visionHelper.cameraHelper.cameraController),
              ),
              ...displayBoxesAroundRecognizedObjects(size),
            ],
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: buttonBackgroundColor,
              ),
            ),
          );
  }
}
