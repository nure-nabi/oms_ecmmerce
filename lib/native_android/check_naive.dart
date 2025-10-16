import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController textEditingController = TextEditingController();
  late String resultText = '';
  var channel = const MethodChannel('uniqueChannelName');

  Future<void> callNativeCode(String userName) async {
    try {
      resultText =
      await channel.invokeMethod('userName', {'username': userName});
      setState(() {});
    } catch (_) {}
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Code'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Enter UserName',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onPressed: () {
                String userName = textEditingController.text;

                if (userName.isEmpty) {
                  userName = "FreeTrained";
                }

                callNativeCode(userName);
              },
              child: const Text('Click Me'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              resultText,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}