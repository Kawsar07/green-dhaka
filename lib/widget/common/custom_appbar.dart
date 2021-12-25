import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  CustomAppBar({this.height = kToolbarHeight, this.child});

  @override
  Size get preferredSize => Size.fromHeight(height);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color:  Colors.white,
      alignment: Alignment.center,
      child: child,
    );
  }
}
