import 'package:flutter/material.dart';

import '../extensions/extensions.dart';

class CustomImput extends StatefulWidget {
  const CustomImput.email({
    super.key,
    this.onChanged,
    this.hint = 'Email',
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
  })  : obscureText = false,
        prefixIcon = Icons.email_outlined,
        keyboardType = TextInputType.emailAddress;

  const CustomImput.password({
    super.key,
    this.onChanged,
    this.hint = 'Password',
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
  })  : obscureText = true,
        prefixIcon = Icons.lock_outline,
        keyboardType = TextInputType.visiblePassword;

  final ValueChanged<String>? onChanged;
  final String hint;
  final bool obscureText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? Function(String? value)? validator;

  @override
  State<CustomImput> createState() => _CustomImputState();
}

class _CustomImputState extends State<CustomImput> {
  late final obscureText = ValueNotifier<bool>(widget.obscureText);

  @override
  void dispose() {
    obscureText.dispose();
    super.dispose();
  }

  OutlineInputBorder _inputBorder({
    Color borderColor = Colors.transparent,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: borderColor),
    );
  }

  Widget? get _suffixIcon {
    if (widget.obscureText) {
      return ValueListenableBuilder<bool>(
        valueListenable: obscureText,
        builder: (_, value, __) => InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () => obscureText.value = !value,
          child: const Icon(
            Icons.remove_red_eye_sharp,
            color: Color(0XFF9A9A9A),
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (_, value, __) => TextFormField(
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: _inputBorder(),
          focusedBorder: _inputBorder(),
          enabledBorder: _inputBorder(),
          errorBorder: _inputBorder(borderColor: Colors.red),
          focusedErrorBorder: _inputBorder(borderColor: Colors.red),
          fillColor: context.colorScheme.secondary,
          filled: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0XFF9A9A9A),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(widget.prefixIcon, color: const Color(0XFF9A9A9A)),
          suffixIcon: _suffixIcon,
        ),
        obscureText: value,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        cursorHeight: 15,
      ),
    );
  }
}
