import 'package:flutter/material.dart';

var kcontainerDecoration = BoxDecoration(
  boxShadow: [BoxShadow(blurRadius: 20)],
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
);
var kformDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: InputBorder.none,
  hintText: 'Enter your email',
);
