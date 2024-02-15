import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/signupcontroller.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/functions/validator.dart';
import 'package:fitnessapp/widgets/logs/signuptextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.LOGIN);
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 33, 33, 33),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_sharp,
                size: 30,
              ),
              onPressed: () {
                Get.offAllNamed(AppRoute.Splash);
              },
            ),
            title: const Text(
              "إنشاء الحساب",
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                children: [
                  GetBuilder<SignupController>(
                    builder: (controller) {
                      return Form(
                          key: controller.signFormKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: SignUpTextField(
                                      label: "الاسم",
                                      icon: Icons.person,
                                      controller: controller.regusername,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return validateInput(
                                            val!, 3, 25, TextInputType.name);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: SignUpTextField(
                                      label: "الكنية",
                                      icon: Icons.person,
                                      controller: controller.nickName,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return validateInput(
                                            val!, 3, 25, TextInputType.name);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SignUpTextField(
                                hint: "example@gmail.com",
                                label: "الايميل",
                                icon: Icons.email,
                                controller: controller.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => validateInput(
                                    val!, 15, 30, TextInputType.emailAddress),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SignUpTextField(
                                  textDirection: TextDirection.ltr,
                                  hint: "000 000 0000 964+",
                                  label: "رقم الهاتف",
                                  // obsecure: false,
                                  icon: Icons.phone,
                                  controller: controller.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (controller.confirmpassword.text !=
                                        controller.regpassword.text) {
                                      return "كلمة المرور غير متطابقة";
                                    } else {
                                      return validateInput(val!, 14, 14,
                                          TextInputType.visiblePassword);
                                    }
                                  }),
                              const SizedBox(
                                height: 50,
                              ),
                              SignUpTextField(
                                label: "كلمة المرور",
                                hint: "********",
                                obsecure: controller.secure,
                                icon: Icons.lock_open,
                                onPressed: controller.showpass,
                                controller: controller.regpassword,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) => validateInput(
                                    val!, 8, 20, TextInputType.visiblePassword),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SignUpTextField(
                                label: "تأكيد كلمة المرور",
                                hint: "********",
                                obsecure: controller.confirmSecure,
                                icon: Icons.password,
                                onPressed: controller.showConfirm,
                                controller: controller.confirmpassword,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) => validateInput(
                                    val!, 8, 20, TextInputType.visiblePassword),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(
                                    color: AppColors.buttonsColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: MaterialButton(
                                  onPressed: controller.signup,
                                  child: const Text(
                                    "إنشاء",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: "Cairo-Regular"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "لديك حساب بالفعل؟ ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.offAllNamed(AppRoute.LOGIN);
                                    },
                                    child: const Text(
                                      "سجل الآن.",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
                ]),
          )),
    );
  }
}
