import 'package:time_tracker/export.dart';

class AddAlert {
  final BuildContext context;
  final String alertTitle;
  final String actionTitle1;
  final String actionTitle2;
  final bool isAlert;
  final String hintText;
  // final Function(String)? onChangedText;
  final TextEditingController? controller;
  final Function()? isAlertFunction;
  final Function()? saveFunction;

  AddAlert({
    // use isAlert=false for adding TextField
    required this.isAlert,
    // this.onChangedText,
    this.controller,
    this.actionTitle1 = "Cancel",
    required this.actionTitle2,
    required this.context,
    required this.alertTitle,
    this.hintText = "Enter your info",
    required this.isAlertFunction,
    required this.saveFunction,
  });
  void addAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(alertTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: isAlert
                ? []
                : [
                    Textfield(
                      hintText: hintText,
                      // onChanged: onChangedText!,
                      controller: controller,
                    ),
                  ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                controller?.clear();
                Navigator.pop(context);
              },
              child: Text(actionTitle1), //Cancel Button
            ),
            OutlinedButton(
              onPressed: isAlert ? isAlertFunction : saveFunction,
              child: Text(actionTitle2), //save button
            ),
          ],
        );
      },
    );
  }
}
