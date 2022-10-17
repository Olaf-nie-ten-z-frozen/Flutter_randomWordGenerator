import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RandomWords(), 
        );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
class RandomWordsState extends State<RandomWords>{
  final randomWordsList = <WordPair>[];
  Widget ListRandomWords{
    return ListView(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();
        final index = item ~/ 2;
        if(index >= RandomWordsState.length){
          randomWordsList.addAll(generateWordPairs().take(10));
        }
      }
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("Wordpair")),
    body: Center(child: ListRandomWords),
    );
  }
}