import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gemini/controller/theme_controller.dart';
import 'package:get/get.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});
  final ThemeController controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              foregroundImage: const AssetImage("assets/me.jpg"),
              radius: 90,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  controller.openUrl("https://www.instagram.com/ml_el7/");
                },
                borderRadius:BorderRadius.circular(39),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary
                  ),
                  child: const Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
              ),
              const SizedBox(width: 15),
              InkWell(
                onTap: (){
                  controller.openUrl("https://github.com/mlel7");
                },
                borderRadius:BorderRadius.circular(39),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary
                  ),
                  child: const Icon(
                      FontAwesomeIcons.github,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
              ),
              const SizedBox(width: 15),
              InkWell(
                onTap: (){
                  controller.openUrl("https://wa.link/ymx5ai");
                },
                borderRadius:BorderRadius.circular(39),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary
                  ),
                  child: const Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
              ),
              
            ],
          ),
        )
      ],
    );
  }
}
