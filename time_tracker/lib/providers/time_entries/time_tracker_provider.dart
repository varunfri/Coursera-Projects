import "package:time_tracker/export.dart";
import 'dart:convert';

class TimeEntriesProvider with ChangeNotifier {
  final String _savePoint = "timeEntries";

  String projectName = "";
  String taskName = "";
  String date = "";
  int hour = 0;
  String note = "";

  // Setters to update project/task/note info
  void updateProjectName(String name) {
    projectName = name;
    notifyListeners();
  }

  void updateTaskName(String name) {
    taskName = name;
    notifyListeners();
  }

  void updateDate(String date) {
    this.date = date;
    notifyListeners();
  }

  void updateHour(int hour) {
    this.hour = hour;
    notifyListeners();
  }

  void updateNote(String note) {
    this.note = note;
    notifyListeners();
  }

  // Function to add new TimeEntry and update entryList
  void addTimeEntry() {
    final data = TimeEntries(
      projectName: projectName,
      taskName: taskName,
      date: date,
      hour: hour,
      note: note,
    );
    _entryList.add(json.encode(data.toJson())); // Store as a JSON string
    notifyListeners(); // Notify UI to update
  }

  // List of saved time entries (in JSON format)
  List<String> _entryList = [];
  List<String> get entryList => _entryList;

  // Convert the list of JSON strings back to TimeEntries objects
  List<TimeEntries> get timeEntries {
    return _entryList.map((e) => TimeEntries.fromJson(json.decode(e))).toList();
  }

  // Save the time entries list into SharedPreferences
  Future<void> saveTimeEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _savePoint,
      _entryList,
    ); // Save as list of JSON strings
    debugPrint("Saved Time Entries: ${prefs.getStringList(_savePoint)}");
  }

  // Load the saved time entries from SharedPreferences
  Future<void> loadTimeEntries() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? timeEntries = prefs.getStringList(_savePoint);

    debugPrint("Retrieved Time Entries: $timeEntries");

    if (timeEntries != null) {
      _entryList = timeEntries; // Set the _entryList to saved entries
    }

    notifyListeners(); // Notify listeners after loading data
  }
}
