import 'package:flutter/material.dart';
import 'package:least_sum/cards.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final cards = shuffleCards(jokersCount: 2);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _position = 0;

  void _incrementPosition() {
    setState(() {
      _position = (_position + 1) % widget.cards.length;
    });
  }

  void _shuffle() {
    setState(() {
      shuffle(widget.cards);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You are looking at the card at position:',
            ),
            Text(
              '$_position',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              widget.cards[_position].toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            MaterialButton(
                onPressed: _shuffle,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Shuffle'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementPosition,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
