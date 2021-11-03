import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;

  const InputField(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(

      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 22),
        labelText: labelText,
        errorText: errorText,
        isDense: true,                      // Added this
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class VisiblePassIcon extends StatefulWidget {
  final bool obscureText;

  const VisiblePassIcon({
    Key? key,
    required this.obscureText,
  }) : super(key: key);

  @override
  _VisiblePassIconState createState() => _VisiblePassIconState();
}

class _VisiblePassIconState extends State<VisiblePassIcon> {
  @override
  Widget build(BuildContext context) {
    if (widget.obscureText) {
      return GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Icon(Icons.visibility),
      );
    } else {
      return Container();
    }
  }
}
