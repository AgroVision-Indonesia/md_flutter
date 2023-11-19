import 'package:flutter/material.dart';

class CustomTextInputProfile extends StatefulWidget {
  const CustomTextInputProfile({
    Key? key,
    required this.controllerName,
    this.hintText = '',
    this.placeholder = '',
    this.readOnly = false,
    this.isObsecure = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.errorText = '',
    this.suffixIcon,
    this.borderColor = Colors.black,
    this.onTap,
    required this.isEnabled,
  }) : super(key: key);

  final TextEditingController controllerName;
  final String hintText;
  final String placeholder;
  final bool readOnly;
  final bool isEnabled;
  final bool isObsecure;

  final int maxLines;
  final int minLines;

  final TextInputType keyboardType;
  final String errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final void Function()? onTap;

  @override
  State<CustomTextInputProfile> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInputProfile> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.placeholder != '')
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            child: Text(
              widget.placeholder,
              textAlign: TextAlign.start,
              style:
                  const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controllerName,
            minLines: widget.minLines,
            keyboardType: widget.keyboardType,
            obscureText: widget.isObsecure,
            maxLines: widget.maxLines,
            onTap: widget.onTap,
            enabled: widget.isEnabled,
            style: TextStyle(
              color: Colors.black, // Set the text color to black when disabled
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              prefixIcon: widget.prefixIcon ?? null,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
            )),
      ],
    );
  }
}
