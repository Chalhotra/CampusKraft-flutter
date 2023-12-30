import 'package:flutter/material.dart';

getSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Center(child: Text(content))));
}
