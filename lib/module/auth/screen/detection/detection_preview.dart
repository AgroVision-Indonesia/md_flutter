import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/component/loading_overlay.dart';
import 'package:md_flutter/module/auth/screen/detection/detection_result.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:md_flutter/utility/http_service.dart';

class DetectionPreview extends StatefulWidget {
  const DetectionPreview({
    super.key,
    required this.selectedModel,
    required this.imageFile,
  });

  final Map selectedModel;
  final File imageFile;

  @override
  State<DetectionPreview> createState() => _DetectionPreviewState();
}

class _DetectionPreviewState extends State<DetectionPreview> {
  HttpService http = HttpService();
  bool isLoading = false;
  String imageFileBase64 = '';
  String imageFilePath = '';
  File? imageFile;

  @override
  void initState() {
    imageFile = widget.imageFile;
    imageFilePath = imageFile!.path;
    imageFileBase64 = base64Encode(imageFile!.readAsBytesSync());
    log('detectionpreview ${widget.selectedModel} ${widget.imageFile}');
    super.initState();
  }

  Future postDetection() {
    setState(() {
      isLoading = true;
    });

    String baseUrlDetection = HttpService.baseUrlDetection;
    String endpoint = 'predict';

    Map<String, String> body = {
      'model': widget.selectedModel['model'],
    };

    log('detectionpredict BODY $body');

    http.postMultipart(baseUrlDetection + endpoint, body: body, file: imageFile!).then((res) {
      log('detectionpredict $res');
      if (res.toString().isNotEmpty) {
        Map detectionResult = res;
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionResult(
              selectedModel: widget.selectedModel,
              imageFile: widget.imageFile,
              detectionResult: detectionResult,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }).catchError(
      (err) {
        log("error predict $err");
        setState(() {
          isLoading = false;
        });
      },
    );
    return Future.value(true);
  }

  Widget buildButton({
    required String buttonLabel,
    required Function() onTap,
    Color backgroundColor = Constant.greenDark,
    Color labelColor = Colors.white,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: backgroundColor,
            border: Border.all(
              width: 2,
              color: labelColor,
            ),
          ),
          child: Text(
            buttonLabel,
            textAlign: TextAlign.center,
            style: TextStyle(color: labelColor, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget buildImagePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(imageFilePath),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: 84,
              height: 84,
              child: const Icon(Icons.error_outline_rounded),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Pratinjau',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: LoadingFallback(
          isLoading: isLoading,
          child: ListView(
            children: [
              buildImagePreview(),
              SizedBox(height: 48),
              buildButton(
                buttonLabel: "Unggah",
                onTap: () {
                  if (imageFile != null) postDetection();
                },
              ),
              SizedBox(height: 12),
              buildButton(
                buttonLabel: "Ulang",
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white,
                labelColor: Constant.greenDark,
              ),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
