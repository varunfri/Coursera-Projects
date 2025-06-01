import 'package:time_tracker/export.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TasksProvider>(context, listen: false).getSavedTasks();
      Provider.of<ProjectsProvider>(context, listen: false).getSavedProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        drawer: Drawers(),
        appBar: AppBar(
          title: Text("Time Tracker"),
          bottom: TabBar(
            tabs: [
              Tab(child: Text("All Entries")),
              Tab(child: Text("Grouped by Projects")),
            ],
          ),
        ),
        body: TabBarView(children: [AllEntries(), GroupProjects()]),
      ),
    );
  }
}
