import 'package:time_tracker/export.dart';

class Settings extends StatefulWidget {
  final String title;
  const Settings({super.key, required this.title});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "App Theme:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Wrap(
                        spacing: 10,
                        children: List<Widget>.generate(3, (int index) {
                          int? _value = 1;
                          List<String> title = ["System", "Light", "Dark"];
                          return ChoiceChip(
                            label: Text(title[index]),
                            selected: theme.index == index,
                            onSelected: (bool selected) {
                              debugPrint("index: $index");
                              if (index != theme.index) {
                                if (selected) {
                                  theme.setIndex = index;
                                }
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
