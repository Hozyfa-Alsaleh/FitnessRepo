import 'package:flutter/material.dart';

class CustomeProgressbar extends StatelessWidget {
  final double total;
  final double perc;
  final String num;
  const CustomeProgressbar(
      {super.key, required this.total, required this.perc, required this.num});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: total,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Container(
            width: perc,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              num,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
