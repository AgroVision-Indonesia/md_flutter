import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:md_flutter/component/custom_text_with_link.dart';
import 'package:md_flutter/component/loading_overlay.dart';
import 'package:md_flutter/module/chatbot/screen/chat/chatbot_view_model.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:provider/provider.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatBotViewModel>(
      create: (context) {
        return ChatBotViewModel();
      },
      builder: (context, child) => ChatBotView(),
    );
  }
}

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatBotViewModel>();
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0.5,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/chatbot/icon_profile_chatbot.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, right: 24),
                      child: Text(
                        'Chat AGV',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                viewModel.onWillPop(context: context);
              },
            ),
          ),
          body: SafeArea(
              child: LoadingFallback(
            isLoading: viewModel.isLoading,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/chatbot/bg_chatbot.png',
                    width: width * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
                SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Column(
                    children: [
                      ChatAiList(),
                      if (viewModel.isAiLoadingResponse) LoadingResponse(),
                      SizedBox(
                        height: 125,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                      child: Container(
                    height: 120,
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(right: 4, left: 24),
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.65,
                                    child: TextFormField(
                                      onTap: () {
                                        viewModel.scrollToBottomList();
                                      },
                                      minLines: 1,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      controller: viewModel.searchController,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Apa yang ingin Anda cari atau tanyakan?...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      textCapitalization: TextCapitalization.sentences,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Image.asset(
                                        'assets/chatbot/send_icon.png',
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    iconSize: 40,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                )
              ],
            ),
          )),
        ),
        onWillPop: () {
          return viewModel.onWillPop(context: context);
        });
  }
}

class LoadingResponse extends StatelessWidget {
  const LoadingResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: CardMessage(data: {
        'position': 'left',
        'message': '...loading...',
      }),
    );
  }
}

class ChatAiList extends StatelessWidget {
  const ChatAiList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatBotViewModel>();
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.dataChat.length,
        itemBuilder: (context, index) {
          Map dataMessage = viewModel.dataChat[index];
          return CardMessage(data: dataMessage);
        },
      ),
    );
  }
}

class CardMessage extends StatelessWidget {
  const CardMessage({super.key, required this.data});
  final Map data;

  @override
  Widget build(BuildContext context) {
    String position = data['position'] ?? 'left';
    bool isMine = position == 'right';
    String message = data['message'] ?? '';
    bool isMessageHasLink = message.toLowerCase().contains('http');
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(
                  text: message,
                ),
              );
              Flushbar(
                flushbarPosition: FlushbarPosition.BOTTOM,
                margin: EdgeInsets.fromLTRB(24, 64, 24, 24),
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                messageText: const Text(
                  'Berhasil salin teks',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.black,
                icon: const Icon(
                  Icons.copy_all,
                  size: 28.0,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 3),
              ).show(context);
            },
            child: Card(
              color: isMine ? Constant.greenDark : Colors.grey[100],
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: isMine
                    ? BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Column(
                  crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.75,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isMessageHasLink
                              ? CustomTextWithLink(
                                  text: message,
                                  textColor: isMine ? Colors.white : Colors.black,
                                  textWeight: FontWeight.w500,
                                  linkColor: isMine ? Colors.lightBlue.shade200 : Colors.blue,
                                )
                              : Text(
                                  message,
                                  style: TextStyle(
                                    color: isMine ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
