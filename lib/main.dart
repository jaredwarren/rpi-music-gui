import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: myProducts.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              // When the user taps the button, show a snackbar.
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Card Tap'),
                ));
              },
              child: Card(
                elevation: 12,
                child: GridTile(
                  child: Image.network(
                      'https://picsum.photos/250?image=' + index.toString()),
                  footer: GridTileBar(
                    backgroundColor: Colors.white,
                    title: Row(
                      children: [
                        Text(
                          myProducts[index]["name"],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow_outlined),
                      color: Colors.black,
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Play Tap'),
                        ));
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          // textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              width: 42.0,
              height: 42.0,
              // child: Image.asset('assets/title.png', fit: BoxFit.cover),
              child: Image.asset('favicon.png', fit: BoxFit.cover),
            ),
            const Spacer(),
            // TODO: add better flex layout?
            SizedBox(
              width: 302.0,
              // height: 42.0,
              child: ProgressBar(
                progress: const Duration(milliseconds: 1000),
                buffered: const Duration(milliseconds: 2000),
                total: const Duration(milliseconds: 5000),
                progressBarColor: Colors.red,
                baseBarColor: Colors.white.withOpacity(0.24),
                bufferedBarColor: Colors.white.withOpacity(0.24),
                thumbColor: Colors.white,
                barHeight: 3.0,
                thumbRadius: 5.0,
                onSeek: (duration) {
                  // _player.seek(duration);
                  print('User selected a new time: $duration');
                },
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
