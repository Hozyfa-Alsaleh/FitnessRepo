import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/views/Home/appinformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouchLogo extends StatelessWidget {
  const CouchLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 48, 99),
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Shooeb fitness trainer",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.offAll(() => const AppInformation());
              },
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ]),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: height! / 1.9,
                width: width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: const Image(
                  image: AssetImage(
                    'assets/images/couch.jpg',
                  ),
                  //  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height! / 3.1,
                alignment: Alignment.bottomCenter,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CoachDisc(
                      text: "-مدرب كمال أجسام وصحة بدنية",
                      fontSize: 20,
                      textalign: TextAlign.start,
                    ),
                    CoachDisc(
                      text: "Bodybuilding and physical health coach",
                      fontSize: 20,
                      textalign: TextAlign.end,
                    ),
                    CoachDisc(
                      text: "-شهادة دبلوم تغذية صحية",
                      fontSize: 20,
                      textalign: TextAlign.start,
                    ),
                    CoachDisc(
                      text: "Health Nutrition Diploma Certificate",
                      fontSize: 20,
                      textalign: TextAlign.left,
                    ),
                    CoachDisc(
                      text: "-شهادة بكلوريوس مختبر(هرمونات+أمراض دم)",
                      fontSize: 18,
                      textalign: TextAlign.start,
                    ),
                    CoachDisc(
                      text:
                          "Bachelor's degree in laboratory (hormones,hematology)",
                      fontSize: 22,
                      textalign: TextAlign.end,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoachDisc extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textalign;
  const CoachDisc(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.textalign});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        textAlign: textalign,
        style: TextStyle(
            //  backgroundColor: Colors.deepOrange,
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajwal'),
      ),
    );
  }
}
//  Text(
//                       '''-مدرب كمال أجسام وصحة بدنية\n
//                       Bodybuilding and physical health coach\n
//                       -شهادة دبلوم تغذية صحية\n
//                       Health Nutrition Diploma Certificate\n
//                       -شهادة بكلوريوس مختبر(هرمونات+أمراض دم)
                      
//                       ''',
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 27,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajwal'),
//                     ),