import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/manageprofilecontroller.dart';
import 'package:fitnessapp/core/functions/validator.dart';

import 'package:fitnessapp/widgets/logs/settingstextfileds.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageProfile extends StatelessWidget {
  final String route;
  final String type;

  const ManageProfile({super.key, required this.route, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageProfileController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(route);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
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
              "إعدادات حسابي",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Tajwal',
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: [
                  GetBuilder<ManageProfileController>(
                    builder: (controller) {
                      return Form(
                          key: controller.settingKey,
                          child: Column(
                            children: [
                              Visibility(
                                visible: type == "user" ? true : false,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: controller.bkcolor,
                                      borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    controller.statusText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Tajwal',
                                        fontSize:
                                            controller.bkcolor == Colors.yellow
                                                ? 22
                                                : 29),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: SettingsTextField(
                                      label: "الاسم",
                                      hint: 'الاسم',
                                      icon: Icons.person,
                                      controller: controller.regusername,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return validateInput(
                                            val!, 3, 10, TextInputType.name);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: SettingsTextField(
                                      hint: 'الكنية',
                                      label: "الكنية",
                                      icon: Icons.person,
                                      controller: controller.nickName,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return validateInput(
                                            val!, 3, 10, TextInputType.name);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SettingsTextField(
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
                              SettingsTextField(
                                  direction: TextDirection.ltr,
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
                              SettingsTextField(
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
                              // SettingsTextField(
                              //   label: "تأكيد كلمة المرور",
                              //   hint: "********",
                              //   obsecure: controller.confirmSecure,
                              //   icon: Icons.password,
                              //   onPressed: controller.showConfirm,
                              //   controller: controller.confirmpassword,
                              //   keyboardType: TextInputType.visiblePassword,
                              //   validator: (val) => validateInput(
                              //       val!, 8, 20, TextInputType.visiblePassword),
                              // ),

                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(
                                    color: AppColors.buttonsColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: MaterialButton(
                                  onPressed: controller.updateMyAccountInfo,
                                  child: const Text(
                                    "تحديث",
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     const Text(
                              //       "لديك حساب بالفعل؟ ",
                              //       style: TextStyle(
                              //           color: Colors.white, fontSize: 23),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         Get.offAllNamed(AppRoute.LOGIN);
                              //       },
                              //       child: const Text(
                              //         "سجل الآن.",
                              //         style: TextStyle(
                              //             color: Colors.red, fontSize: 20),
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          ));
                    },
                  ),
                ]),
          )),
    );
  }
}
