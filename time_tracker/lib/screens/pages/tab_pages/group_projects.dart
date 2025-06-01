import 'package:time_tracker/export.dart';

class GroupProjects extends StatelessWidget {
  const GroupProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Consumer<ProjectsProvider>(
        builder: (context, projectProvider, child) {
          return Scaffold(
            floatingActionButton: Visibility(
              visible: projectProvider.projects.isEmpty ? true : false,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Projects(title: "Projects"),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: projectProvider.projects.isEmpty
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
                          Text("No Projects Found"),
                          Text(
                            "Tap the + button to add your first project.",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )
                  : Center(child: Column(children: [])),
            ),
          );
        },
      ),
    );
  }
}
