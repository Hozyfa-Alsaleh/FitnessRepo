import 'package:captainshoaib/MiddleWares/authmiddleware.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/views/Home/CoursesPages/dayexercise.dart';
import 'package:captainshoaib/views/coachpages/contactinfo.dart';
import 'package:captainshoaib/views/coachpages/packages/packagecrud.dart';
import 'package:captainshoaib/views/coachpages/packages/packages.dart';
import 'package:captainshoaib/views/AuthScreens/authscreen.dart';
import 'package:captainshoaib/views/AuthScreens/login.dart';
import 'package:captainshoaib/views/AuthScreens/signup.dart';
import 'package:captainshoaib/views/Home/homepage.dart';
import 'package:captainshoaib/views/Home/information.dart';
import 'package:captainshoaib/views/Home/playerprofile.dart';
import 'package:captainshoaib/views/coachpages/addsuppcourse.dart';
import 'package:captainshoaib/views/coachpages/displayexercise.dart';
import 'package:captainshoaib/views/coachpages/displayfoodcourse.dart';
import 'package:captainshoaib/views/coachpages/exedetails.dart';
import 'package:captainshoaib/views/coachpages/exercises.dart';
import 'package:captainshoaib/views/coachpages/foodcourse.dart';
import 'package:captainshoaib/views/coachpages/homepage.dart';
import 'package:captainshoaib/views/coachpages/playerdetails.dart';
import 'package:captainshoaib/views/coachpages/playerimages.dart';
import 'package:captainshoaib/views/coachpages/players.dart';
import 'package:captainshoaib/views/coachpages/profile.dart';
import 'package:captainshoaib/views/coachpages/requests/playersrequests.dart';
import 'package:captainshoaib/views/coachpages/requests/requestinfo.dart';
import 'package:captainshoaib/views/coachpages/suppcourse.dart';
import 'package:captainshoaib/views/subscribes/choosepackage.dart';
import 'package:captainshoaib/views/subscribes/contactinformation.dart';
import 'package:captainshoaib/views/subscribes/payscreen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getpages = [
  GetPage(
      name: AppRoute.Splash,
      page: () => const AuthScreen(),
      middlewares: [AuthMiddleWare()]),
  GetPage(name: AppRoute.LOGIN, page: () => const Login()),
  GetPage(
    name: AppRoute.SIGNUP,
    page: () => const SignUp(),
  ),
  GetPage(name: AppRoute.PlayerInfo, page: () => const Information()),
  GetPage(name: AppRoute.HOME, page: () => const HomePage()),
  GetPage(name: AppRoute.PlayerProfile, page: () => const PlayerProfile()),
  GetPage(name: AppRoute.coachprofile_C, page: () => const CoachProfile()),
  GetPage(name: AppRoute.players_C, page: () => const MyPlayers()),
  GetPage(name: AppRoute.playerdetails_C, page: () => const PlayerDetailes()),
  GetPage(name: AppRoute.palyerImages_C, page: () => const PlayerImages()),
  GetPage(name: AppRoute.packages, page: () => const ChoosePackage()),
  GetPage(name: AppRoute.payscreen, page: () => const PayScreen()),
  GetPage(name: AppRoute.adminExe, page: () => const AdminExercises()),
  GetPage(name: AppRoute.foodcourse, page: () => const AddFoodCourse()),
  GetPage(name: AppRoute.displayFood, page: () => const DisplayFoodCourse()),
  GetPage(name: AppRoute.captineHomePage, page: () => const CaptinHomePage()),
  GetPage(name: AppRoute.captineHomePage, page: () => const CaptinHomePage()),
  GetPage(name: AppRoute.displayExe, page: () => const DisplayExercise()),
  GetPage(name: AppRoute.exeDetails, page: () => const ExeDetails()),
  GetPage(name: AppRoute.suppcourse, page: () => const SuppCourse()),
  GetPage(name: AppRoute.addSupp, page: () => const AppSuppCourse()),
  GetPage(name: AppRoute.CaptinePackages, page: () => const Packages()),
  GetPage(name: AppRoute.packageCRUD, page: () => const PackageCRUD()),
  GetPage(name: AppRoute.contact, page: () => const ContactInformation()),
  GetPage(name: AppRoute.dayExercise, page: () => const DayExercise()),
  GetPage(name: AppRoute.contactInfo, page: () => const ContactInfo()),
  GetPage(name: AppRoute.requestInfo, page: () => const RequestInfo()),
  GetPage(name: AppRoute.playersRequests, page: () => const PlayersRequests()),
];
