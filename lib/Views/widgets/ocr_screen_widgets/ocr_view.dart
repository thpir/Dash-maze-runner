import 'package:camera/camera.dart';
import 'package:dash_maze_runner/controller/ocr_helper.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcrView extends StatefulWidget {
  const OcrView({super.key});

  @override
  State<OcrView> createState() => _OcrViewState();
}

class _OcrViewState extends State<OcrView> {
  @override
  void initState() {
    super.initState();
    initOcrCamera();
  }

  @override
  void deactivate() async {
    super.deactivate();
    final ocrHelper = Provider.of<OcrHelper>(context, listen: false);  
    await ocrHelper.closeVision();
  }

  Future<void> initOcrCamera() async {
    final ocrHelper = Provider.of<OcrHelper>(context, listen: false);
    await ocrHelper.initVision().then((errorText) {
      if (errorText != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorText)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Camera initialized succesfully")));
      }
    }).then((_) {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ocrHelper = Provider.of<OcrHelper>(context);
    return ocrHelper.cameraHelper.isCameraInitialized
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
                    CameraPreview(ocrHelper.cameraHelper.cameraController),
              ),
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
