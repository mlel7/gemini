import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Your Ai Assistand",
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Using this software you can ask you questions and receive articles using ai",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset("assets/onboarding.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 10,right: 10,bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.offAllNamed("/home");
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 30),
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Continue"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
