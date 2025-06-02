import 'package:time_tracker/export.dart';
import 'package:intl/intl.dart';

class GroupProjects extends StatelessWidget {
  const GroupProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Consumer3<TasksProvider, ProjectsProvider, TimeEntriesProvider>(
        builder: (context, taskProvider, projectProvider, entryProvider, child) {
          final grouped = entryProvider.groupedByProject;
          return Scaffold(
            floatingActionButton: Visibility(
              visible:
                  projectProvider.projects.isEmpty ||
                      taskProvider.tasks.isEmpty ||
                      entryProvider.entryList.isEmpty
                  ? true
                  : false,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TimeEntry(title: "Add Project Timings"),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child:
                  projectProvider.projects.isEmpty ||
                      taskProvider.tasks.isEmpty ||
                      entryProvider.entryList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_outline_outlined,
                            size: 60,
                            color: Colors.grey[500],
                          ),
                          Text("No Time Entries Found"),
                          Text(
                            "Tap the + button to add work timings.",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )
                  // : ListView.builder(
                  //     itemCount: entryProvider.groupedByProject.length,
                  //     itemBuilder: (context, index) {
                  //       final data = entryProvider.groupedByProject;
                  //       debugPrint(data.toString());
                  //       return Card(
                  //         child: ListTile(
                  //           title: Text(),
                  //           subtitle: Text(""),
                  //           trailing: IconButton(
                  //             onPressed: () {
                  //               showDialog(
                  //                 context: context,
                  //                 builder: (_) {
                  //                   return AlertDialog(
                  //                     title: Text("Project Details"),
                  //                     content: Column(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       children: [],
                  //                     ),
                  //                     actions: [
                  //                       TextButton(
                  //                         onPressed: () {
                  //                           Navigator.pop(context);
                  //                         },
                  //                         child: Text("Close"),
                  //                       ),
                  //                     ],
                  //                   );
                  //                 },
                  //               );
                  //             },
                  //             icon: Icon(Icons.info_outlined),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  : ListView(
                      children: grouped.entries.map((project) {
                        final projectName = project.key;
                        final entries =
                            project.value['entries'] as List<TimeEntries>;
                        final totalTime = project.value['totalTime'] as int;
                        final hours = totalTime ~/ 60;
                        final minutes = totalTime % 60;

                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ExpansionTile(
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project: $projectName',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Total Time: $hours hr: $minutes min',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            children: entries.map((entry) {
                              final date = DateFormat("dd-MM-yyyy").format(
                                DateTime.parse(
                                  entry.date ?? DateTime.now().toString(),
                                ),
                              );
                              return ListTile(
                                title: Text("Task Name: ${entry.taskName}"),
                                subtitle: Text(
                                  'Total Time: ${entry.hour ?? "0:00"}\t Date: $date',
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
