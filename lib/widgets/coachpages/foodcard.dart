import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String text;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  const FoodCard({
    super.key,
    required this.text,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 10, 76, 131),
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(192, 1, 52, 110), width: 3.5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 24, fontFamily: 'Tajwal'),
                ),
                Icon(
                  icon,
                  color: Colors.black,
                  size: 45,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller,
              style: const TextStyle(
                  fontSize: 25, color: Colors.black, fontFamily: 'Tajwal'),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  hintText: hint,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            )
          ]),
    );
  }
}
