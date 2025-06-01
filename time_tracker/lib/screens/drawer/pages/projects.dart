// import 'package:time_tracker/export.dart';

// class Projects extends StatefulWidget {
//   final String title;

//   const Projects({required this.title, super.key});

//   @override
//   State<Projects> createState() => _ProjectsState();
// }

// class _ProjectsState extends State<Projects> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Safe to use context-dependent operations like Navigator or InheritedWidgets
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController? projectController = TextEditingController();
//     return Consumer<ProjectsProvider>(
//       builder: (context, projectProvider, child) {
//         return Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               AddAlert(
//                 saveFunction: () async {
//                   debugPrint("Saving the Projects");
//                   if (projectController.text.isNotEmpty) {
//                     projectProvider.addProject(
//                       projectName: projectController.text,
//                     );
//                     await projectProvider.saveProjects();
//                     Navigator.pop(context);
//                   }
//                   projectController.clear();
//                 },
//                 controller: projectController,
//                 isAlert: false,
//                 hintText: "Enter project name",
//                 actionTitle2: "Save",
//                 context: context,
//                 alertTitle: "Add Project",
//                 isAlertFunction: () {},
//               ).addAlert();
//             },
//             tooltip: "Add Projects",
//             child: Icon(Icons.add),
//           ),
//           appBar: AppBar(title: Text(widget.title)),
//           body: Padding(
//             padding: EdgeInsetsGeometry.all(20),
//             child: projectProvider.projects.isEmpty
//                 ? Center(
//                     child: Column(
//                       spacing: 10,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.work_outline_outlined,
//                           size: 60,
//                           color: Colors.grey[500],
//                         ),

//                         Text("No Projects Found"),
//                         Text(
//                           "Tap the + button to add your first project.",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: projectProvider.projects.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: ListTile(
//                           title: Text(projectProvider.projects[index]),
//                           trailing: IconButton(
//                             onPressed: () {
//                               AddAlert(
//                                 isAlert: true,
//                                 actionTitle2: "Delete",
//                                 context: context,
//                                 alertTitle: "Sure Deleting?",
//                                 isAlertFunction: () async {
//                                   debugPrint("Deleting project: $index");
//                                   projectProvider.delProject(index: index);
//                                   await projectProvider.saveProjects();
//                                   debugPrint("Saved Projects");

//                                 },
//                                 saveFunction: () {},
//                               ).addAlert();
//                             },
//                             icon: Icon(Icons.delete_outline_outlined),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:time_tracker/export.dart';

class Projects extends StatefulWidget {
  final String title;

  const Projects({required this.title, super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to use context-dependent operations like Navigator or InheritedWidgets
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController? projectController = TextEditingController();
    return Consumer<ProjectsProvider>(
      builder: (context, projectProvider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AddAlert(
                saveFunction: () async {
                  debugPrint("Saving the Projects");
                  if (projectController.text.isNotEmpty) {
                    projectProvider.addProject(
                      projectName: projectController.text,
                    );
                    await projectProvider.saveProjects();
                    if (mounted) {
                      // Check if the widget is still mounted
                      Navigator.pop(context);
                    }
                  }
                  projectController.clear();
                },
                controller: projectController,
                isAlert: false,
                hintText: "Enter project name",
                actionTitle2: "Save",
                context: context,
                alertTitle: "Add Project",
                isAlertFunction: () {},
              ).addAlert();
            },
            tooltip: "Add Projects",
            child: Icon(Icons.add),
          ),
          appBar: AppBar(title: Text(widget.title)),
          body: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: projectProvider.projects.isEmpty
                ? Center(
                    child: Column(
                      spacing: 10,
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
                : ListView.builder(
                    itemCount: projectProvider.projects.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(projectProvider.projects[index]),
                          trailing: IconButton(
                            onPressed: () {
                              AddAlert(
                                isAlert: true,
                                actionTitle2: "Delete",
                                context: context,
                                alertTitle: "Sure Deleting?",
                                isAlertFunction: () async {
                                  Navigator.pop(context);
                                  projectProvider.delProject(index: index);
                                  await projectProvider.saveProjects();
                                },
                                saveFunction: () {},
                              ).addAlert();
                            },
                            icon: Icon(Icons.delete_outline_outlined),
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
