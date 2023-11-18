import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetectionResult extends StatefulWidget {
  const DetectionResult({
    super.key,
    required this.selectedModel,
    required this.detectionResult,
    required this.imageFile,
  });

  final Map selectedModel;
  final Map detectionResult;
  final File imageFile;

  @override
  State<DetectionResult> createState() => _DetectionResultState();
}

class _DetectionResultState extends State<DetectionResult> {
  String imageFilePath = '';
  Map detectionResult = {};
  File? imageFile;

  @override
  void initState() {
    imageFile = widget.imageFile;
    imageFilePath = imageFile!.path;
    log('detectionresult ${widget.selectedModel} ${widget.imageFile} ${widget.detectionResult}');
    super.initState();
  }

  Widget buildImageResult() {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 10.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Image.file(
                File(imageFilePath),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    width: 84,
                    height: 84,
                    child: const Icon(Icons.error_outline_rounded),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.selectedModel['title'],
                          style: TextStyle(fontSize: 16),
                        ),
                        Flexible(
                          child: Text(
                            widget.detectionResult['time'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Constant.greenMoreLight,
                          ),
                          child: Text(
                            widget.detectionResult['class'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ((widget.detectionResult['confidence'] * 100)).toString() + '%',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailResult() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.detectionResult['description'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  alertClose({
    required String title,
    required String message,
    required BuildContext context,
    String firstButtonLabel = 'Lanjutkan',
    String secondButtonLabel = 'Batal',
    required Function() firstButtonOnTap,
    required Function() secondButtonOnTap,
  }) {
    Alert(
      context: context,
      // type: AlertType.info,
      style: AlertStyle(
        isCloseButton: false,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titlePadding: EdgeInsets.only(bottom: 8, top: 10),
      ),
      title: title,
      content: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(16),
          child: Text(
            firstButtonLabel,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: firstButtonOnTap,
          color: Constant.greenDark,
        ),
        DialogButton(
          radius: BorderRadius.circular(16),
          child: Text(
            secondButtonLabel,
            style: TextStyle(
              color: Constant.greenDark,
            ),
          ),
          onPressed: secondButtonOnTap,
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Constant.greenDark,
          ),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            alertClose(
              title: 'Konfirmasi',
              message:
                  'Apakah Anda yakin ingin keluar dari halaman ini? Hasil deteksi tidak tersimpan.',
              context: context,
              firstButtonOnTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              secondButtonOnTap: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Hasil',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            buildImageResult(),
            buildDetailResult(),
          ],
        ),
      ),
    );
  }
}
