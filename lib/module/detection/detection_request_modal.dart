import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:md_flutter/module/detection/components/expanded_section.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:md_flutter/utility/helper.dart';

class DetectionRequestModal extends StatefulWidget {
  const DetectionRequestModal({
    super.key,
    required this.onSubmit,
  });

  final Function onSubmit;

  @override
  State<DetectionRequestModal> createState() => _DetectionRequestModalState();
}

class _DetectionRequestModalState extends State<DetectionRequestModal> {
  List<String> typeList = [
    'Buah-buahan',
    'Tanaman',
  ];
  bool isStrechedDrowDown = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController selectedTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget buildButton({
    required String buttonLabel,
    required Function() onTap,
    bool isActive = false,
    Color backgroundColor = Constant.greenDark,
    Color labelColor = Colors.white,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        onTap: isActive ? onTap : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: isActive ? backgroundColor : Colors.grey.shade500,
            border: Border.all(
              width: 2,
              color: labelColor,
            ),
          ),
          child: Text(
            buttonLabel,
            textAlign: TextAlign.center,
            style: TextStyle(color: labelColor, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget buildFormTextField({
    required TextEditingController controller,
    required String hintText,
    required int minLines,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: TextFormField(
        onChanged: (text) {
          // setState(() {
          //   String textTmp = text.replaceAll(' ', '');
          //   // isShowSendButton = textTmp.length > 2 || imageBase64.isNotEmpty;
          // });
        },
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Nunito Sans',
        ),
        minLines: minLines,
        maxLines: 7,
        keyboardType: TextInputType.multiline,
        controller: controller,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Constant.greyDark,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }

  Widget buildFormDropdown({
    required TextEditingController controller,
    required List options,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          isStrechedDrowDown = !isStrechedDrowDown;
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 0.5),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text.isEmpty ? 'Pilih jenis' : controller.text,
                  style: TextStyle(
                    color: controller.text.isEmpty ? Constant.greyDark : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  isStrechedDrowDown
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
              ],
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            elevation: 2,
            child: ExpandedSection(
              expand: isStrechedDrowDown,
              height: 100,
              child: ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTypeController.text = options.elementAt(index);
                        isStrechedDrowDown = !isStrechedDrowDown;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      margin: EdgeInsets.only(top: 8, left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: options.elementAt(index) == selectedTypeController.text
                            ? Constant.greenMedium
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        options.elementAt(index),
                        style: TextStyle(
                          fontSize: 12,
                          color: options.elementAt(index) == selectedTypeController.text
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                  // return RadioListTile(
                  //   title: Text(
                  //     options.elementAt(index),
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  //   value: index,
                  //   groupValue: selectedTypeController.text,
                  //   onChanged: (val) {
                  //     setState(() {
                  //       selectedTypeController.text = val as String;
                  //       selectedTypeController.text = options.elementAt(index);
                  //     });
                  //   },
                  // );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(top: 12, right: 24, left: 24, bottom: 40),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: 28,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Request",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close_rounded, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 56),
                child: ListView(
                  controller: controller,
                  children: [
                    Text(
                      'Apa request khusus yang ingin Anda ajukan pada AgroVision?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Jenis',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildFormDropdown(controller: selectedTypeController, options: typeList),
                    SizedBox(height: 12),
                    Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildFormTextField(
                      controller: nameController,
                      hintText: 'Nama buah atau tanaman',
                      minLines: 1,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Alasan',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildFormTextField(
                      controller: reasonController,
                      hintText: 'Sebutkan alasan anda merequest buah atau tanaman ini',
                      minLines: 3,
                    ),
                    SizedBox(height: 24),
                    buildButton(
                      buttonLabel: 'Submit',
                      onTap: () {
                        Navigator.of(context).pop();
                        Helper(context: context).showToast(
                          message: 'Request telah dikirim',
                          backgroundColor: Constant.greenMoreVeryLight,
                          borderColor: Constant.greenMoreVeryLight,
                          messageColor: Colors.black,
                          icon: Image.asset(
                            'assets/detection_home/img_check_circle.png',
                            width: 36,
                            height: 36,
                          ),
                        );
                      },
                      isActive: selectedTypeController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          reasonController.text.isNotEmpty,
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
}
