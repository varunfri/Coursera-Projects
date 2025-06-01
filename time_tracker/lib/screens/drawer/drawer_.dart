import 'package:time_tracker/export.dart';


class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage("asset/logo/logo.png"),
                  ),
                ],
              ),
            ),
          ),
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
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Settings(title: "Tasks")),
                    );
                    debugPrint("Settings");
                  },
                  leading: Icon(Icons.settings_outlined),
                  title: Text("Settings"),
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
