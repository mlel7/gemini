import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini/themes.dart';
import 'package:gemini/view/home_page.dart';
import 'package:gemini/view/onBoarding.dart';
import 'package:get/get.dart';
void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
  
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const OnBoardingPage(),
      theme: lightMode,
      darkTheme:darkMode,
      themeMode: themeMode,
      initialRoute: "/onboarding",
      getPages: [
        GetPage(name: "/onboarding", page: () => const OnBoardingPage()),
        GetPage(name: "/home", page:()=>const HomePage())
      ],
    );
  }
}
