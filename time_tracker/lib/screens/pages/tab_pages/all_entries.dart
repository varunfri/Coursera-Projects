import 'package:time_tracker/export.dart';
import 'package:time_tracker/screens/pages/time_entry.dart';

class AllEntries extends StatelessWidget {
  const AllEntries({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Consumer<TimeEntriesProvider>(
          builder: (context, entriesProvider, child) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  debugPrint("Adding Time entry");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TimeEntry(title: "Add Project Timings"),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
              body: entriesProvider.entryList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.hourglass_empty_outlined,
                            size: 58,
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
                      itemCount: entriesProvider.entryList.length,
                      itemBuilder: (context, index) {
                        final data = entriesProvider.timeEntries[index];
                        return Card(
                          child: ListTile(
                            title: Text("Project: ${data.projectName}"),
                            subtitle: Text("Task: ${data.taskName}"),
                            trailing: IconButton(
                              onPressed: () {
                                AddAlert(
                                  isAlert: true,
                                  actionTitle2: "Delete",
                                  context: context,
                                  alertTitle: "Sure Deleting?",
                                  isAlertFunction: () {
                                    entriesProvider.delEntry(index: index);
                                    Navigator.pop(context);
                                  },
                                  saveFunction: null,
                                ).addAlert();
                              },
                              icon: Icon(Icons.delete_outline_outlined),
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
