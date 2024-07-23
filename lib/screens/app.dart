import 'package:database/config/config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Database",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
