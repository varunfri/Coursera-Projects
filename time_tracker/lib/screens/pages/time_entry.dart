import 'package:time_tracker/export.dart';
import 'package:intl/intl.dart';

class TimeEntry extends StatefulWidget {
  final String title;
  const TimeEntry({super.key, required this.title});

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  // final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TimeEntriesProvider>(context, listen: false).clearDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Consumer3<TasksProvider, ProjectsProvider, TimeEntriesProvider>(
        builder: (context, task, project, entry, value) {
          return task.tasks.isEmpty || project.projects.isEmpty
              ? Center(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work_outline_outlined,
                        size: 60,
                        color: Colors.grey[500],
                      ),
                      Text(
                        "Add Tasks & Projects First.",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _CardStyle(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Text(
                              "Select Project",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          _DropList(
                            enabled: project.projects.isEmpty ? false : true,
                            hintText: project.projects.isEmpty
                                ? "Add Projects First"
                                : "Select Project Name",
                            options: project.projects,
                            onSelected: (v) {
                              debugPrint("Selected $v");
                              if (v != null) {
                                entry.updateProjectName(v);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Text(
                              "Select Task",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          _DropList(
                            enabled: task.tasks.isEmpty ? false : true,
                            hintText: task.tasks.isEmpty
                                ? "Add Tasks First"
                                : "Select Task Name",
                            options: task.tasks,
                            onSelected: (v) {
                              debugPrint("Selected $v");
                              if (v != null) {
                                entry.updateTaskName(v);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Text(
                              "Select Date",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              entry.selectDate(
                                context: context,
                                selectedDate: DateTime.now(),
                              );
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintStyle: Theme.of(
                                  context,
                                ).textTheme.titleMedium,
                                hintText: entry.getDate.isEmpty
                                    ? "Select Date"
                                    : DateFormat(
                                        "dd-MM-yyyy",
                                      ).format(DateTime.parse(entry.getDate)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Text(
                              "Select Worked Time",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              entry.selectTime(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintStyle: Theme.of(
                                  context,
                                ).textTheme.titleMedium,
                                hintText: entry.getTime.isEmpty
                                    ? "Select Worked Time"
                                    : "${entry.getTime.split(":").first} hr - ${entry.getTime.split(":").last} min",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Text(
                              "Add Note",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextField(
                            // focusNode: _focusNode,
                            onChanged: (e) {
                              entry.updateNote(e);
                              debugPrint(e);
                            },
                            onTapOutside: (event) {
                              // FocusScope.of(context).requestScopeFocus();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              hintText: "Add note",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style,
                            onPressed:
                                (entry.date.isEmpty ||
                                    entry.note.isEmpty ||
                                    entry.projectName.isEmpty ||
                                    entry.time.isEmpty ||
                                    entry.taskName.isEmpty)
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Fill all the fields"),
                                      ),
                                    );
                                  }
                                : () {
                                    AddAlert(
                                      isAlert: true,
                                      actionTitle2: "Save",
                                      context: context,
                                      alertTitle: "Add Time Entry",
                                      isAlertFunction: () {
                                        // entry.loadTimeEntries();

                                        Navigator.pop(context);
                                        entry.addTimeEntry();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Saved Successfully"),
                                          ),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Homepage(),
                                          ),
                                        );
                                      },
                                      saveFunction: null,
                                    ).addAlert();
                                  },
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class _DropList extends StatefulWidget {
  final List<String> options;
  final bool enabled;
  final String hintText;
  final Function(String?) onSelected;
  const _DropList({
    required this.hintText,
    required this.options,
    required this.onSelected,
    required this.enabled,
  });

  @override
  State<_DropList> createState() => _DropListState();
}

class _DropListState extends State<_DropList> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enabled: widget.enabled,
      width: double.infinity,
      hintText: widget.hintText,
      onSelected: widget.onSelected,
      dropdownMenuEntries: widget.options.map((e) {
        return DropdownMenuEntry(value: e, label: e);
      }).toList(),
      inputDecorationTheme: Theme.of(
        context,
      ).dropdownMenuTheme.inputDecorationTheme,
      menuStyle: Theme.of(context).dropdownMenuTheme.menuStyle,
    );
  }
}

class _CardStyle extends StatelessWidget {
  final List<Widget> children;
  const _CardStyle({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: children,
        ),
      ),
    );
  }
}
