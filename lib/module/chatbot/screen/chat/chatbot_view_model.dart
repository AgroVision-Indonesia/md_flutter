import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:md_flutter/utility/http_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChatBotViewModel extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  HttpService http = HttpService();
  late BuildContext _context;
  List<Map> dataChat = [
    {
      'position': 'left',
      'message': 'Halo! Selamat datang di AgroVision!',
    },
    {
      'position': 'left',
      'message': 'Apa yang dapat saya bantu?',
    },
  ];
  bool isAiLoadingResponse = false;
  ChatBotViewModel({required BuildContext context}) {
    _context = context;
  }

  postMessage() async {
    unfocusedKeyboard();
    isAiLoadingResponse = true;
    dataChat.add(
      {
        'position': 'right',
        'message': searchController.text,
      },
    );
    scrollToBottomList();
    Map body = {"prompt": searchController.text, "offset": 240};
    notifyListeners();
    await http.post(HttpService.baseUrlChatBot, body: body).then((res) {
      dataChat.add({
        'position': 'left',
        'message': res['Response'],
      });
      scrollToBottomList();
      isAiLoadingResponse = false;
      searchController.clear();
      notifyListeners();
    }).catchError(
      (err) {
        log(err.toString());
        isAiLoadingResponse = false;
        notifyListeners();
      },
    );
  }

  alertFailed({required String message, String title = 'Gagal!', required BuildContext context}) {
    Alert(
      style: AlertStyle(
        isCloseButton: true,
      ),
      context: context,
      type: AlertType.error,
      title: title,
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).show();
  }

  Future<bool> onWillPop({required BuildContext context}) {
    Navigator.of(context).pop();
    return Future.value(false);
  }

  void unfocusedKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void scrollToBottomList() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }
}
