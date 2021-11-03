import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Function? onPressed;

  const FormButton({this.text = "", this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton.icon(
      onPressed: onPressed as void Function()?,
      icon: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      label: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Colors.white,
        size: 16.0,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .026),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
