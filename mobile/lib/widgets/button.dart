import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key, required this.title,
      required this.color,
      required this.onTapped}) : super(key: key);

  final String? title;
  final Color? color;
  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            boxShadow: [
              BoxShadow(
                color: color!.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ]),
        child: Center(
          child: Text(
            title.toString(),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 25.0,
              letterSpacing: 0.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
