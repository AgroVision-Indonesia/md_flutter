import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
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
  }) : super(key: key);

  final TextEditingController controllerName;
  final String hintText;
  final String placeholder;
  final bool readOnly;
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
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
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
              style: const TextStyle(fontSize: 14, color: Colors.white),
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
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: widget.prefixIcon != null
              ? InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  hintText: widget.hintText,
                )
              : InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  suffixIcon: widget.suffixIcon,
                  hintText: widget.hintText,
                ),
        ),
      ],
    );
  }
}
