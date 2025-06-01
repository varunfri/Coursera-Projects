import 'package:time_tracker/export.dart';

class Tasks extends StatefulWidget {
  final String title;
  const Tasks({super.key, required this.title});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<TasksProvider>(context, listen: false).getSavedTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController? taskController = TextEditingController();
    return Consumer<TasksProvider>(
      builder: (context, taskProvider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AddAlert(
                controller: taskController,
                isAlertFunction: () {},
                // onChangedText: (e) {},
                hintText: "Enter task name",
                isAlert: false,
                actionTitle2: "Save",
                saveFunction: () async {
                  taskController.text.isNotEmpty
                      ? {
                          debugPrint(
                            "task controller : ${taskController.text}",
                          ),
                          taskProvider.addTasks(taskName: taskController.text),
                          await taskProvider.saveTasks(),
                          taskController.clear(),
                          if (context.mounted) {Navigator.pop(context)},
                        }
                      : debugPrint("Enter task name");
                },
                context: context,
                alertTitle: "Add Tasks",
              ).addAlert();
            },
            tooltip: "Add Tasks",
            child: Icon(Icons.add),
          ),
          appBar: AppBar(title: Text(widget.title)),
          body: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: taskProvider.tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.note_add_outlined,
                          size: 60,
                          color: Colors.grey[500],
                        ),
                        Text("No Tasks Found"),
                        Text(
                          "Tap the + button to add your first task.",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          debugPrint("Update Task");
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(taskProvider.tasks[index]),
                            trailing: IconButton(
                              onPressed: () {
                                debugPrint("delete?");
                                AddAlert(
                                  saveFunction: () {},
                                  isAlert: true,
                                  actionTitle2: "Delete",
                                  context: context,
                                  alertTitle: "Sure deleting?",
                                  isAlertFunction: () async {
                                    debugPrint("Sure Delete!?");
                                    taskProvider.delTasks(index: index);
                                    await taskProvider.saveTasks();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ).addAlert();
                              },
                              icon: Icon(Icons.delete_outline),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
