class TimeEntries {
  final String? projectName;
  final String? taskName;
  final String? date;
  final String? hour;
  final String? note;

  TimeEntries({
    required this.projectName,
    required this.taskName,
    required this.date,
    required this.hour,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      "projectName": projectName,
      "taskName": taskName,
      "date": date,
      "hour": hour,
      "note": note,
    };
  }

  factory TimeEntries.fromJson(Map<String, dynamic> json) {
    return TimeEntries(
      projectName: json['projectName'],
      taskName: json['taskName'],
      date: json['date'],
      hour: json['hour'],
      note: json['note'],
    );
  }
}
