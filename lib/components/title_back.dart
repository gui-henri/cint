import 'package:flutter/material.dart';

Widget titleBack(BuildContext context, String text, String route) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ))),
        ),
      ),
      Text(
        text,
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
    ]),
  );
}
