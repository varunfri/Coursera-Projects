import 'package:expense_manager/export.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => TimeProvider()),
  ];
}
