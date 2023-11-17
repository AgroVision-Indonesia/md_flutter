import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:md_flutter/component/image_picker_dialog.dart';

class ImagePickerHandler {
  ImagePickerDialog? imagePicker;
  AnimationController? _controller;
  ImagePickerListener? _listener;
  int? type;
  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker?.dismissDialog();
    XFile? images = (await ImagePicker().pickImage(source: ImageSource.camera));
    final File image = File(images!.path);
    cropImage(image);
  }

  openGallery() async {
    imagePicker?.dismissDialog();
    XFile? images = (await ImagePicker().pickImage(source: ImageSource.gallery));
    final File image = File(images!.path);
    cropImage(image);
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker?.initState();
  }

  Future cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
      maxWidth: 512,
      maxHeight: 512,
    );
    File files = File(croppedFile!.path);
    _listener?.userImage(files, this.type as int);
  }

  showDialog(BuildContext context, {int tipe = 1}) {
    this.type = tipe;
    imagePicker?.getImage(context);
  }

  showDialog2(BuildContext context, {int tipe = 1}) {
    this.type = tipe;
    imagePicker?.getImage2(context);
  }
}

mixin ImagePickerListener {
  userImage(File _image, int type);
}
