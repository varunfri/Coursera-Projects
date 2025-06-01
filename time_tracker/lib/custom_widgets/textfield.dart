import 'package:time_tracker/export.dart';

class Textfield extends StatelessWidget {
  final String hintText;
  // final Function(String) onChanged;
  final TextEditingController? controller;
  const Textfield({
    required this.hintText,
    required this.controller,
    // required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      // onChanged: onChanged,
      controller: controller,
    );
  }
}
