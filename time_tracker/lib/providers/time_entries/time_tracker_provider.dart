import 'package:intl/intl.dart';
import "package:time_tracker/export.dart";
import 'dart:convert';

class TimeEntriesProvider with ChangeNotifier {
  final String _savePoint = "timeEntries";

  void selectDate({
    required BuildContext context,
    required DateTime selectedDate,
  }) async {
    // Defining first and last date for the DatePickerDialog
    final firstDate = DateTime(2020);
    final lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: MediaQuery.of(context).platformBrightness != Brightness.dark
              ? ThemeData.light()
              : ThemeData.dark(),
          child: child!,
        );
      },
      initialDate: selectedDate, // Initial date to show
      firstDate: firstDate, // First date that can be picked
      lastDate: lastDate, // Last date that can be picked
    );

    if (picked != null && picked != selectedDate) {
      updateDate(picked.toString());
    }
  }

  void selectTime({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: MediaQuery.of(context).platformBrightness != Brightness.dark
              ? ThemeData.light()
              : ThemeData.dark(),
          child: child!,
        );
      },
      context: context,
      initialTime: initialTime,
    );

    if (picked != null || picked == initialTime) {
      final dateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked!.hour,
        picked.minute,
      );

      final String hour12 = DateFormat(
        "hh:mm",
      ).format(DateTime.parse(dateTime.toString()));

      updateHour(hour12);
    }
  }

  String projectName = "";
  String taskName = "";
  String date = "";
  String time = "";
  String note = "";

  String get getDate => date;
  String get getTime => time;

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

  void clearDate() {
    date = "";
    time = "";
    debugPrint(date);
    notifyListeners();
  }

  void updateHour(String time) {
    this.time = time;
    notifyListeners();
  }

  void updateNote(String note) {
    this.note = note;
    notifyListeners();
  }

  void delEntry({required int index}) async {
    _entryList.removeAt(index);
    await saveTimeEntries();
    notifyListeners();
  }

  void addTimeEntry() async {
    final data = TimeEntries(
      projectName: projectName,
      taskName: taskName,
      date: date,
      hour: time,
      note: note,
    );
    _entryList.add(json.encode(data.toJson())); // Store as a JSON string
    debugPrint(_entryList.toString());
    await saveTimeEntries();
    notifyListeners(); // Notify UI to update
  }

  List<String> _entryList = [];
  List<String> get entryList => _entryList;

  List<TimeEntries> get timeEntries {
    return _entryList.map((e) => TimeEntries.fromJson(json.decode(e))).toList();
  }

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

  // Group the TimeEntries by project name
  // Map<String, List<TimeEntries>> get groupedByProject {
  //   Map<String, List<TimeEntries>> grouped = {};

  //   // Iterate over all time entries and group them by project name
  //   for (var entry in timeEntries) {
  //     if (grouped.containsKey(entry.projectName)) {
  //       grouped[entry.projectName]?.add(entry);
  //     } else {
  //       grouped[entry.projectName!] = [entry];
  //     }
  //   }
  //   return grouped;
  // }
  Map<String, Map<String, dynamic>> get groupedByProject {
    Map<String, Map<String, dynamic>> grouped = {};

    // Iterate over all time entries and group them by project name
    for (var entry in timeEntries) {
      // If the projectName is already in the map, add the current entry
      if (grouped.containsKey(entry.projectName)) {
        grouped[entry.projectName]?['entries']?.add(entry);
      } else {
        // If not, initialize the group with the first entry
        grouped[entry.projectName!] = {
          'entries': [entry],
          'totalTime': 0, // Initialize total time
        };
      }

      // Add the time for this entry to the totalTime of the group
      String time = entry.hour ?? '0:00'; // Default time is '0:00' if it's null
      int totalMinutes = calculateTotalMinutes([time]);
      grouped[entry.projectName]!['totalTime'] += totalMinutes;
    }

    return grouped;
  }

  int calculateTotalMinutes(List<String> timeStrings) {
    int totalMinutes = 0;

    for (String time in timeStrings) {
      List<String> parts = time.split(':');
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      totalMinutes += (hours * 60) + minutes;
    }

    return totalMinutes;
  }

  String convertMinutesToHours(int totalMinutes) {
    int hours = totalMinutes ~/ 60; // Integer division to get hours
    int minutes = totalMinutes % 60; // Remainder is the minutes

    return "$hours:${minutes.toString().padLeft(2, '0')}"; // Format to hh:mm
  }
}
