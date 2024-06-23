import 'package:flutter/material.dart';
import 'package:gemini/themes.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ThemeController extends GetxController{
  toggleTheme(){
    if(Get.isDarkMode){
      Get.changeThemeMode(themeMode = ThemeMode.light);
    }
    else{
      Get.changeThemeMode(themeMode = ThemeMode.dark);
    }
  }
  openUrl(String url)async{
    try{
      await launchUrl(Uri.parse(url));
    }catch(e){
      Get.showSnackbar(GetSnackBar(title: "Error",message: e.toString(),));
    }
  }
 
}