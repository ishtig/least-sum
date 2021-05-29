import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/components/cards.dart' as CardComponent;
import 'package:least_sum/components/dealer.dart';
import 'package:stack/stack.dart' as StackDs;

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
  final int numOfPlayers = 4;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cards = shuffleCards(jokersCount: 2);
  var cardsInHand = HashMap<int, List<CardComponent.Card>>();
  var centerStack = StackDs.Stack<CardComponent.Card>();

  void _distributeCards() {
    setState(() {
      cardsInHand =
          deal(cards, numOfPlayers: widget.numOfPlayers, numOfCards: 5);
      centerStack.push(cards.pop());
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
      body: buildGameGround(),
      floatingActionButton: FloatingActionButton(
        onPressed: _distributeCards,
        tooltip: 'Increment',
        child: Icon(Icons.unarchive_outlined),
      ),
    );
  }

  Widget buildGameGround() {
    if (cardsInHand.length == 0) {
      return Text('Click distribute fab to distribute cards and start game');
    }
    return Column(children: [
      Text(getStringForCardsWith(0, true)),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(getStringForCardsWith(1, false)),
        Text(centerStack.top().toString()),
        Text(getStringForCardsWith(2, false))
      ]),
      Text(getStringForCardsWith(3, true)),
    ]);
  }

  String getStringForCardsWith(int player, bool isHorizontal) {
    String string = '';
    for (CardComponent.Card card in cardsInHand[player]) {
      string += (isHorizontal ? ' ' : '\n') + card.toString();
    }
    return string;
  }
}
