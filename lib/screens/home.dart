import 'package:database/config/config.dart';

import '../db/database.dart';
import '../planetas/planetas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Planetas> planetario = [];
  @override
  void initState() {
    super.initState();
    openDB();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: Text("Database")),
      body: Builder(
        builder: (context) {
          query();
          if (planetario.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            );
          } else {
            return ListView.builder(
                itemCount: planetario.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    leading: Icon(Icons.blur_circular_rounded),
                    title: Text(
                      "Planeta: ${planetario[index].nombre}",
                    ),
                    subtitle: Text("radio: ${planetario[index].radius}"),
                  ));
                });
          }
        },
      ),
    );
  }

  void openDB() {
    Database.Connect().whenComplete(() async {
      await agregar();
    });
  }

  Future<void> agregar() async {
    List<Planetas> planets = [
      Planetas(1, "Mercurio", 0.3, 34521.36),
      Planetas(2, "Venus", 0.3, 54663.36),
      Planetas(3, "Tierra", 1, 674423.36),
      Planetas(4, "Marte", 0.3, 66547.36),
    ];

    await Database.insert(planets);
  }

  Future<void> query() async {
    planetario = await Database.getPlanets().whenComplete(() {
      setState(() {});
    });
  }
}
