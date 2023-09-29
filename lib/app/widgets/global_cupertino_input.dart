import 'package:flutter/cupertino.dart';

class GlobalCupertinoInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode focusNode;
  final String placeholder;
  final String? validatorErrorText;
  final dynamic validator;
  final String? Function(String val)? changed;
  final VoidCallback? showPasswordOrClear;
  final IconData? icon;
  final bool? isPassword;
  final int? maxLength;
  final Color labelStyle;
  final Color colorStyle;
  final Color borderSide;
  final Color? colorIcon;

  final bool? passwordVisible;

  const GlobalCupertinoInput({
    Key? key,
    required this.placeholder,
    this.validator,
    this.validatorErrorText,
    this.changed,
    required this.focusNode,
    required this.controller,
    this.keyboardType,
    this.showPasswordOrClear,
    this.icon,
    this.isPassword,
    this.passwordVisible,
    this.maxLength,
    required this.labelStyle,
    required this.colorStyle,
    required this.borderSide,
    this.colorIcon,
  }) : super(key: key);

  @override
  State<GlobalCupertinoInput> createState() => _GlobalCupertinoInputState();
}

class _GlobalCupertinoInputState extends State<GlobalCupertinoInput> {
  late ValueNotifier<String> _text;

  @override
  void initState() {
    super.initState();
    _text = ValueNotifier(widget.controller.text);
    widget.controller.addListener(
      () {
        final String textFromController = widget.controller.text;
        if (textFromController.isEmpty && _text.value.isNotEmpty) {
          _text.value = '';
        } else if (textFromController.isNotEmpty) {
          _text.value = textFromController;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoTextField(
        placeholder: widget.placeholder, 
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        maxLength: widget.maxLength,
        onTap: () {
          if (!widget.focusNode.hasFocus) {
            widget.changed?.call(_text.value.isEmpty ? '' : _text.value);
          }
        },
        obscureText: widget.isPassword == false
            ? widget.passwordVisible ?? true
            : widget.passwordVisible ?? false
                ? widget.isPassword ?? true
                : false,
        style: TextStyle(
          color: widget.colorStyle,
        ),
        focusNode: widget.focusNode,
        onChanged: widget.changed,
        
      ),
    );
  }
}
