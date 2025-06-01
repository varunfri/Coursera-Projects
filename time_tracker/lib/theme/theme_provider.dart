import 'package:time_tracker/export.dart';

class ThemeProvider with ChangeNotifier {
  final String _savePoint = "themeData";
  bool sysTheme = false;
  bool lTheme = false;
  bool dTheme = false;
  ThemeData theme = ThemeData.dark();
  int _index = 0;
  int get index => _index;
  set setIndex(int? i) {
    _index = i!;
    saveTheme();

    notifyListeners();
  }

  void saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_savePoint, _index);
    debugPrint("Saved Theme: ${prefs.getInt(_savePoint)}");
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setIndex = prefs.getInt(_savePoint);
  }

  ThemeMode get currentThemeMode {
    switch (_index) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
