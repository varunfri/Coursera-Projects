import 'package:flutter/material.dart';
import 'package:time_tracker/export.dart';
import 'package:time_tracker/screens/drawer/pages/tasks.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Center(child: Text("Time Tracker"))),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Projects(title: "Projects"),
                      ),
                    );
                    debugPrint("Add Projects");
                  },
                  leading: Icon(Icons.folder_copy_outlined),
                  title: Text("Projects"),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Tasks(title: "Tasks")),
                    );
                    debugPrint("Add Tasks");
                  },
                  leading: Icon(Icons.note_add_outlined),
                  title: Text("Tasks"),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
