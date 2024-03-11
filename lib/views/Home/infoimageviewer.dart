import 'dart:io';

import 'package:flutter/material.dart';

class InfoImageView extends StatelessWidget {
  final String path;
  const InfoImageView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      // appBar: AppBar(backgroundColor: Colors.transparent, toolbarHeight: 40),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: InteractiveViewer(
          constrained: true,
          panAxis: PanAxis.vertical,
          child: Image.file(File(path), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
