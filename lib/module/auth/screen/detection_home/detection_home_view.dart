import 'package:flutter/material.dart';
import 'package:md_flutter/utility/constant.dart';

class DetectionHome extends StatefulWidget {
  const DetectionHome({super.key});

  @override
  State<DetectionHome> createState() => _DetectionHomeState();
}

class _DetectionHomeState extends State<DetectionHome> {
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
        padding: const EdgeInsets.only(right: 24, left: 24, bottom: 16, top: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, right: 6, left: 6, bottom: 2),
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constant.greenMoreVeryLight,
              ),
              child: Image.asset(imageAsset),
            ),
            const SizedBox(height: 4),
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
    );
  }

  Widget buildCardRequest() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 10.0,
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
            // ClipPath(
            //   clipper: CustomClipPath(),
            //   child: Container(
            //     color: Colors.blue,
            //     height: 400,
            //   ),
            // ),
            const SizedBox(height: 24),
            buildCardDetection(
              title: 'Deteksi kematangan buah',
              subtitle: 'Ketahui kualitas buahmu dengan melakukan identifikasi kematangannya!',
              imageAsset: 'assets/detection_home/img_detection_buah.png',
              buttonLabel: 'Pilih buah',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            buildCardDetection(
              title: 'Deteksi penyakit tanaman',
              subtitle: 'Cegah lebih awal dengan mengetahui daignosis penyakit pada tanamanmu!',
              imageAsset: 'assets/detection_home/img_detection_tanaman.png',
              buttonLabel: 'Pilih tanaman',
              onTap: () {},
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
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 50,
      h - 100,
      w,
      h,
    );
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
