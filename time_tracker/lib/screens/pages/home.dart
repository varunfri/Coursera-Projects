import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Add Tasks");
        },
        child: Icon(Icons.add),
      ),
        body: TabBar(tabs: [
          Text("Tab 1")
        ]),
    );
  }
}
