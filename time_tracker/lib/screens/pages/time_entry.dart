import 'package:time_tracker/export.dart';

class TimeEntry extends StatefulWidget {
  final String title;
  const TimeEntry({super.key, required this.title});

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.title)));
  }
}

class _DropList extends StatelessWidget {
  final List<String> options;
  final String hintText;
  final Function(String?) onSelected;
  const _DropList({
    super.key,
    required this.hintText,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: hintText,
      onSelected: onSelected,
      dropdownMenuEntries: options.map((e) {
        return DropdownMenuEntry(value: e, label: e);
      }).toList(),
    );
  }
}
