import 'package:flutter/material.dart';

class ChatBotViewModel extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List dataChat = [
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
  ChatBotViewModel() {}

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
  }
}
