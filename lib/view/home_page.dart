import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini/controller/theme_controller.dart';
import 'package:gemini/themes.dart';
import 'package:gemini/view/info_page.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../model/message.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeController controller = Get.put(ThemeController());
  final TextEditingController messageController = TextEditingController();
  final PageController pageController = PageController();
  int current_page = 0;
  final List<Message> messages = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello How can I help you", isUser: false),
  ];

  Future<void> callGeminiModel() async {
    try {
      setState(() {
        messages.add(Message(text: messageController.text, isUser: true));
      });

      final model = GenerativeModel(
          model: "gemini-pro", apiKey: dotenv.env["GOOGLE_API_KEY"]!);
      final prompt = messageController.text.trim();
      final content = [Content.text(prompt)];
      messages.add(Message(text: "Wating...", isUser: false));
      final response = await model.generateContent(content);
      setState(() {
        messages.remove(messages.last);
        messages.add(Message(text: response.text!, isUser: false));
      });
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "$e",
      ));
    }
    messageController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_page,
        onTap: (int index){
          setState(() {
            current_page=index;
            pageController.jumpToPage(current_page);
          });
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showUnselectedLabels: false,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
        
      ]
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        centerTitle: false,
        title: Text(
          "Gemini",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Image.asset("assets/gpt-robot.png"),
        titleSpacing: 0,
      
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    controller.toggleTheme();
                  },
                  icon: Icon(
                    (themeMode == ThemeMode.dark)
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: (themeMode == ThemeMode.dark)
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                  ))),
        ],
      ),
      body:PageView(
        controller: pageController,
        
        onPageChanged: (int index){
          setState(() {
            current_page = index;
          });
        },
        children: [
          Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment:
                      message.isUser ? Alignment.topRight : Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: message.isUser
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                    ),
                    child: SelectableText(
                      message.text,
                      style: message.isUser
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                        hintText: "Message ",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: callGeminiModel,
                    child: Image.asset("assets/send.png"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
          InfoPage(),
        ],
        ) 
          );
  }
}
