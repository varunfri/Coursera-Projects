import 'package:time_tracker/export.dart';

class ProjectsProvider with ChangeNotifier {
  final String _savePoint = "projectList";

  List<String> _projects = [];
  List<String> get projects => _projects;
  set _setProjects(List<String>? projects) {
    _projects = projects ?? [];
    notifyListeners();
  }

  void addProject({required String projectName}) {
    _projects.add(projectName);
    notifyListeners();
  }

  void delProject({required int index}) {
    _projects.removeAt(index);
    notifyListeners();
  }

  void clearProjects() {
    _projects.clear();
    notifyListeners();
  }

  void updateProject({required int index, required String projectName}) {
    _projects[index] = projectName;
    notifyListeners();
  }

  Future<void> saveProjects() async {
    final prefs = await SharedPreferences.getInstance();
    // save projects to local
    debugPrint("Saving the info");
    await prefs.setStringList(_savePoint, _projects);
    debugPrint("Saved Projects: ${prefs.getStringList(_savePoint)}");
  }

  Future<void> getSavedProjects() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("Retreving saved projects");
    _setProjects = prefs.getStringList(_savePoint);
    debugPrint("Saved Projects: $_projects");
  }
}
