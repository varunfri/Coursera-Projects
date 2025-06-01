import 'package:time_tracker/export.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => TimeEntriesProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => ProjectsProvider()),
    ChangeNotifierProvider(create: (_) => TasksProvider()),
  ];
}
