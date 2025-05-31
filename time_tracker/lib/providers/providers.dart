import 'package:time_tracker/export.dart';


class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ExpenseProvider()),
    ChangeNotifierProvider(create: (_)=> ThemeProvider())
  ];
}
