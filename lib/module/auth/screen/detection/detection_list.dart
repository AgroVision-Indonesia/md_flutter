import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/component/image_picker_handler.dart';
import 'package:md_flutter/component/loading_overlay.dart';
import 'package:md_flutter/module/auth/screen/detection/detection_preview.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:md_flutter/utility/http_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetectionList extends StatefulWidget {
  const DetectionList({
    super.key,
    required this.indexDetection,
  });

  // 0 -> penyakit tanaman
  // 1 -> kematangan buah
  final int indexDetection;

  @override
  State<DetectionList> createState() => _DetectionListState();
}

class _DetectionListState extends State<DetectionList>
    with TickerProviderStateMixin, ImagePickerListener {
  HttpService http = HttpService();
  bool isLoading = false;

  Map detectionModels = {};
  Map selectedModel = {};

  AnimationController? animationController;
  ImagePickerHandler? imagePicker;

  // list model bentuknya masih map

  List wordings = [
    {
      'key': 'plant-disease',
      'title': "Deteksi penyakit tanaman",
      'subtitle': "Silakan pilih tanaman yang ingin diperiksa penyakitnya"
    },
    {
      'key': 'ripeness',
      'title': "Deteksi kematangan buah",
      'subtitle': "Silakan pilih buah yang ingin dicek tingkat kematangannya"
    },
  ];

  @override
  void initState() {
    getDetectionData();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, animationController);
    imagePicker!.init();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future getDetectionData() {
    setState(() {
      isLoading = true;
    });

    String baseUrlDetection = HttpService.baseUrlDetection;
    String endpoint = 'detection-data';

    http.get(baseUrlDetection + endpoint).then((res) {
      log('detectiondata $res');
      if (res.toString().isNotEmpty) {
        setState(() {
          detectionModels = res[wordings[widget.indexDetection]['key']];
        });
      }
      log('detectiondata models $detectionModels');
      setState(() {
        isLoading = false;
      });
    }).catchError(
      (err) {
        log("error detection-data $err");
        setState(() {
          isLoading = false;
        });
      },
    );
    return Future.value(true);
  }

  Widget buildWording() {
    String title = wordings[widget.indexDetection]['title'] ?? '';
    String subtitle = wordings[widget.indexDetection]['subtitle'] ?? '';
    return Container(
      margin: EdgeInsets.only(top: 36, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardDetectionModel({required Map data}) {
    return Card(
      margin: EdgeInsets.only(top: 12, right: 24, left: 24),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl: data['imgUrl'],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // image: DecorationImage(image: imageProvider),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Constant.greenDark),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 12),
                Text(data['title']),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedModel = data;
                });
                imagePicker!.showDialog(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Constant.greenDark),
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  'Deteksi',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetectionModelList() {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 32),
      child: ListView.builder(
        itemCount: detectionModels.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // log('detectiondata index $index');
          String key = (index + 1).toString();
          return buildCardDetectionModel(data: detectionModels[key]);
        },
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
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Deteksi',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: LoadingFallback(
          isLoading: isLoading,
          child: ListView(
            children: [
              buildWording(),
              buildDetectionModelList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  userImage(File _image, int type) {
    String fileName = _image.path.split("/").last;
    File imageFile = _image;

    if (selectedModel.isNotEmpty)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectionPreview(
            selectedModel: selectedModel,
            imageFile: imageFile,
          ),
        ),
      );
  }
}
