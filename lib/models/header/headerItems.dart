import 'package:flutter/cupertino.dart';

class HeaderItem {
  final String title;
  final VoidCallback? onTap;
  final bool isButtom;

  HeaderItem({required this.title, this.onTap, this.isButtom = false});


}