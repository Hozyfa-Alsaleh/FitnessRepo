import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final String name;
  final String time;
  final String price;
  final String details;

  const PackageCard(
      {super.key,
      required this.name,
      required this.time,
      required this.price,
      required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 30),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0.8, 4))
          ],
          gradient:
              const LinearGradient(transform: GradientRotation(40), colors: [
            Color.fromARGB(200, 24, 126, 200),
            Color.fromARGB(220, 12, 96, 165),
            Color.fromARGB(230, 6, 52, 90),
          ])),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اسم الباقة: $name',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'مدة الباقة: $time يوم',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'سعر الباقة: $price د.ع',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'تفاصيل : $details',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ]),
    );
  }
}
