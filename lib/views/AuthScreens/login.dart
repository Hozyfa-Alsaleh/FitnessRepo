import 'package:fitnessapp/controllers/logincontroller.dart';
import 'package:fitnessapp/core/StaticLData/appimageslinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/asktologout.dart';
import 'package:fitnessapp/core/functions/validator.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/logs/loginbutton.dart';
import 'package:fitnessapp/widgets/logs/logincustomfield.dart';
import 'package:fitnessapp/widgets/logs/resetpassbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return WillPopScope(
      onWillPop: () {
        askToLogOut("", "هل تود الخروج من التطبيق؟");
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImagesLinks.loginBKG),
                      fit: BoxFit.cover)),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 70),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("سجل الآن\nوإبدأ رحلتك لجسم أفضل",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GetBuilder<LoginController>(builder: (controller) {
                      return Form(
                        key: controller.loginFormKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                                hint: "اسم المستخدم",
                                // icon: Icons.person,
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.username,
                                validator: (val) {
                                  return validateInput(
                                      val!, 3, 10, TextInputType.emailAddress);
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              hint: "*********",
                              obsecure: controller.secure,
                              // icon: Icons.lock_open,
                              onPressed: controller.showpass,
                              controller: controller.password,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (val) {
                                return validateInput(
                                    val!, 8, 30, TextInputType.visiblePassword);
                              },
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                LoginButton(
                                  text: "تسجيل",
                                  onTap: () {
                                    controller.loginMethod();
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ForgetPassButton(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAllNamed(AppRoute.SIGNUP);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: width! / 2.8,
                                    //color: Colors.amber,
                                    alignment: Alignment.centerRight,
                                    child: const Text(
                                      "إنشاء حساب",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Cairo-Regular"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.reqStatus == RequestStatus.loading
                                ? const LinearProgressIndicator()
                                : const SizedBox()
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ))),
    );
  }
}
