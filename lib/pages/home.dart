import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/game.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _usernameTextController = TextEditingController();

  void _tryStart(BuildContext context, int size) {
    if (_usernameTextController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder:(context) => GamePage(
            username: _usernameTextController.text,
            size: size
          ),
        )
      );
    } else {
      // stackoverflow.com/questions/45948168/how-to-create-toast-in-flutter
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please input a username."),
        )
      );
    }
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Theme.of(context)
        .buttonTheme
        .colorScheme
        ?.background
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _usernameTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(3, (index) => TextButton(
                style: _buttonStyle(context),
                onPressed: () => _tryStart(context, index + 3),
                child: Text("Play ${index + 3} x ${index + 3}"),
              )),
            ),
          ],
        ),
      ),
    );
  }
}