import 'package:flutter/material.dart';

Widget titleBack(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ))),
        ),
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 26, color: Colors.black),
      ),
    ]),
  );
}
