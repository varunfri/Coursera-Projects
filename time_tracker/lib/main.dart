import "package:time_tracker/export.dart";

void main() {
  runApp(MultiProvider(providers: Providers.providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: AppTheme(context: context).lightTheme(),
          darkTheme: AppTheme(context: context).darkTheme(),
          themeMode: theme.currentThemeMode,
          debugShowCheckedModeBanner: false,
          title: "Time Tracker",
          home: Homepage(),
        );
      },
    );
  }
}
