import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:md_flutter/module/detection/detection_list_view.dart';
import 'package:md_flutter/module/detection/detection_request_modal.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:md_flutter/utility/http_service.dart';

class DetectionHome extends StatefulWidget {
  const DetectionHome({super.key});

  @override
  State<DetectionHome> createState() => _DetectionHomeState();
}

class _DetectionHomeState extends State<DetectionHome> {
  void showModalRequest({
    double elevation = 1,
    BuildContext? context,
    int dataLength = 2,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context!,
      builder: (context) {
        return DetectionRequestModal(
          onSubmit: () {},
        );
      },
    );
  }

  Widget buildAppbar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo/logo_appbar.png',
            height: 30,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(Constant.randomImageUrl),
          )
        ],
      ),
    );
  }

  Widget buildWelcome() {
    return const Column(
      children: [
        Text(
          'Selamat datang di Deteksi!',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'Apa yang ingin kamu deteksi hari ini?',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildCardDetection({
    required String title,
    required String subtitle,
    required String imageAsset,
    required buttonLabel,
    required Function() onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Container(
                height: 96,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        color: Constant.greenDark,
                        height: 60,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, right: 6, left: 6, bottom: 2),
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constant.greenMoreVeryLight,
                        ),
                        child: Image.asset(imageAsset),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, left: 24, right: 24, bottom: 16),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            width: 0.5,
                            color: Constant.greenDark,
                          ),
                        ),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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

  Widget buildCardRequest() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 10.0,
      child: InkWell(
        onTap: () {
          showModalRequest(context: context);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Image.asset('assets/detection_home/img_detection_request.png', width: 50),
                const SizedBox(width: 12),
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mau request buah atau tanaman?',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Kamu butuh buah dan tanaman lain? Requst disini',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            buildAppbar(),
            buildWelcome(),
            const SizedBox(height: 24),
            buildCardDetection(
              title: 'Deteksi kematangan buah',
              subtitle: 'Ketahui kualitas buahmu dengan melakukan identifikasi kematangannya!',
              imageAsset: 'assets/detection_home/img_detection_buah.png',
              buttonLabel: 'Pilih buah',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetectionList(indexDetection: 1),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            buildCardDetection(
              title: 'Deteksi penyakit tanaman',
              subtitle: 'Cegah lebih awal dengan mengetahui daignosis penyakit pada tanamanmu!',
              imageAsset: 'assets/detection_home/img_detection_tanaman.png',
              buttonLabel: 'Pilih tanaman',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetectionList(indexDetection: 0),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            buildCardRequest(),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 20) // Line to bottom-left
      ..quadraticBezierTo(
        size.width / 2,
        size.height + 20,
        size.width,
        size.height - 20,
      ) // Quadratic Bezier to bottom-right
      ..lineTo(size.width, 0); // Line to top-right

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
