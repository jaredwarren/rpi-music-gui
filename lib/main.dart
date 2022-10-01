import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'grid/grid.dart';
import 'player/player.dart';

void main() {
  runApp(MyApp());
}

//
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // TODO: make this a config option
  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      cache: GraphQLCache(), link: HttpLink("http://localhost:8000/graphql")));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<Map> myProducts =
      List.generate(100, (index) => {"id": index, "name": "Product $index"})
          .toList();

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(_counter);
    });
  }

  final String readCounters = """
query {
  songs {
    title
    thumb
		rfid
		url
    id
  }
}
""";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Config Tap'),
              ));
            },
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql(readCounters),
          // variables: {
          // 'counterId': 23,
          // },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading');
          }

          List songs = result.data!['songs'];
          if (songs.isEmpty) {
            return const Text('No repositories');
          }

          return loadSongGrid(context, songs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: loadPlayer(context),
    );
  }
}
