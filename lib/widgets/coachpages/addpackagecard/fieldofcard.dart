import 'package:flutter/material.dart';

class FieldOfCard extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const FieldOfCard({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          TextFormField(
            minLines: 1,
            maxLines: 5,
            style: const TextStyle(color: Colors.white, fontSize: 25),
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
