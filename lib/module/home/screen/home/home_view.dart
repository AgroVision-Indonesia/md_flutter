import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/module/chatbot/screen/chat/chatbot_view.dart';
import 'package:md_flutter/module/home/screen/home/components/card_article.dart';
import 'package:md_flutter/utility/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map userData = {
    'username': 'Joko',
    'token': 8,
    'token_used_today': 2,
  };

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

  Widget buildCardDashboard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  IconlyBroken.calendar,
                  size: 10,
                ),
                SizedBox(width: 6),
                Text(
                  '11 Nov 2023 | 13.47',
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Hello, ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${userData['username']}👋',
                      style: TextStyle(
                        fontSize: 16,
                        color: Constant.greenMedium,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/logo/logo_av.png', width: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${userData['token']} token',
                        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Kamu telah menggunakan ${userData['token_used_today']} token hari ini',
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildCardDetection() {
    return Container(
      margin: const EdgeInsets.only(right: 54, left: 54),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Constant.greenMedium,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/main_menu/img_lamp.png',
            width: 32,
          ),
          const SizedBox(width: 6),
          const Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deteksi sekarang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Cek kematangan buah dan penyakit tanaman dengan mudah dan praktis, hanya dengan kamera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(IconlyBroken.arrow_right, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildTitle({required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Constant.greenMoreLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              'Lihat Semua',
              style: TextStyle(
                fontSize: 10,
                color: Constant.greenDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubtitle({required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(top: 12, right: 24, left: 24, bottom: 12),
      child: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  Widget buildArticleList() {
    return AspectRatio(
      aspectRatio: 16 / 6,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 24, right: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CardArticle();
        },
      ),
    );
  }

  Widget buildArtikel() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(title: 'Artikel'),
          buildSubtitle(subtitle: 'Temukan artikel menarik seputar agrikultur disini'),
          buildArticleList(),
          buildSubtitle(subtitle: 'Mungkin kamu suka'),
          buildArticleList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 64,
          width: 64,
          child: FittedBox(
            child: FloatingActionButton(
              shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => ChatBotScreen(),
                ));
              },
              child: Image.asset(
                'assets/main_menu/icon_chatbot.png',
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            buildAppbar(),
            Stack(
              children: [
                buildCardDashboard(),
                Container(margin: const EdgeInsets.only(top: 100), child: buildCardDetection()),
              ],
            ),
            buildArtikel(),
          ],
        ),
      ),
    );
  }
}
