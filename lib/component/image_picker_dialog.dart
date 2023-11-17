import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/component/image_picker_handler.dart';
import 'package:md_flutter/utility/constant.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler? _listener;
  AnimationController? _controller;

  ImagePickerDialog(this._listener, this._controller);

  dynamic context;

  int _type = 1;

  Animation<double>? _drawerContentsOpacity;

  Animation<Offset>? _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller!),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null || _drawerDetailsPosition == null || _drawerContentsOpacity == null) {
      return;
    }
    _controller?.forward();
    showDialog(
      context: context,
      // ignore: unnecessary_new
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition!,
        child: FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity!),
          child: this,
        ),
      ),
    );
  }

  getImage2(BuildContext context) {
    if (_controller == null || _drawerDetailsPosition == null || _drawerContentsOpacity == null) {
      return;
    }
    _controller?.forward();
    _type = 2;
    showDialog(
      context: context,
      builder: (BuildContext context) => SlideTransition(
        position: _drawerDetailsPosition!,
        child: FadeTransition(
          opacity: ReverseAnimation(_drawerContentsOpacity!),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller?.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller?.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _listener?.openCamera(),
                  //  _type == 1
                  //     ? _listener.openCamera()
                  //     : _listener.openCamera2(),
                  child: roundedButton(
                    "Camera",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Constant.greenDark,
                    const Color(0xFFFFFFFF),
                    icon: Icon(
                      IconlyLight.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _listener?.openGallery(),
                  // _type == 1
                  //     ? _listener.openGallery()
                  //     : _listener.openGallery2(),
                  child: roundedButton(
                    "Gallery",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Constant.greenDark,
                    const Color(0xFFFFFFFF),
                    icon: Icon(
                      IconlyLight.image,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => dismissDialog(),
                  child: roundedButton("Cancel", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      Colors.white, Constant.greenDark),
                ),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
    String buttonLabel,
    EdgeInsets margin,
    Color bgColor,
    Color textColor, {
    Icon? icon,
  }) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(20.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Container(
              margin: EdgeInsets.only(right: 8),
              child: icon,
            ),
          Text(
            buttonLabel,
            style: new TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
