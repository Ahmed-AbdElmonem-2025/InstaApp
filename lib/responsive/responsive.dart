import 'package:flutter/material.dart';


class Responsive extends StatefulWidget {
  final webScreen;
  final mobScreen;
  const Responsive({super.key, this.webScreen, this.mobScreen});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        if (BoxConstraints.maxWidth>600) {
        return  widget.webScreen;
        } else {
        return  widget.mobScreen;
        }
      
    },);
  }
}