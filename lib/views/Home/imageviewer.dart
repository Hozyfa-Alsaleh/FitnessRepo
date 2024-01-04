import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String path;
  const ImageView({super.key, required this.path});

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
            child: Image(
              image: NetworkImage(path),
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
