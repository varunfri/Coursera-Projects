import 'package:time_tracker/export.dart';

class TasksProvider with ChangeNotifier {
  final String _savePoint = "taskList";
  List<String> _tasks = [];
  List<String> get tasks => _tasks;
  set _setTasks(List<String>? savedTasks) {
    _tasks = savedTasks ?? [];
  }

  // String? _taskName;
  // set setTaskName(String? task) {
  //   _taskName = task;
  //   notifyListeners();
  // }
  // String? get taskName => _taskName;

  void addTasks({required String taskName}) {
    _tasks.add(taskName);
    notifyListeners();
  }

  void delTasks({required int index}) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }

  void updateTask({required int index, required String taskName}) {
    _tasks[index] = taskName;
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("Saving to memory");
    if (_tasks.isNotEmpty || _tasks.isEmpty) {
      await prefs.setStringList(_savePoint, _tasks);
    }
    debugPrint("Saved Tasks: ${prefs.getStringList(_savePoint)}");
  }

  Future<void> getSavedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _setTasks = prefs.getStringList(_savePoint);
    debugPrint("Retrived save tasks: $_tasks");
  }
}
