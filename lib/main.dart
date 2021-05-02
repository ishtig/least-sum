import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/components/cards.dart' as CardComponent;
import 'package:least_sum/components/dealer.dart';

import 'components/shuffle.dart';

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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cards = shuffleCards(jokersCount: 2);
  var cardsInHand = HashMap<int, List<CardComponent.Card>>();

  void _distributeCards() {
    setState(() {
      cardsInHand = deal(cards, numOfPlayers: 4, numOfCards: 5);
    });
  }

  void _shuffle() {
    setState(() {
      cards = shuffleCards(jokersCount: 2);
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
      body: ListView.builder(
          itemCount: cardsInHand.length,
          itemBuilder: (context, position) {
            return Text(getStringForCardsWith(position));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _distributeCards,
        tooltip: 'Increment',
        child: Icon(Icons.unarchive_outlined),
      ),
    );
  }

  String getStringForCardsWith(int player) {
    String string = '';
    for (CardComponent.Card card in cardsInHand[player]) {
      string += ' ' + card.toString();
    }
    return string;
  }
}
