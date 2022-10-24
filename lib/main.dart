import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final randomWordsList = <WordPair>[];
  final _savedWordsPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        if (index >= randomWordsList.length) {
          randomWordsList.addAll(generateWordPairs().take(10));
        }
        return _buildRow(randomWordsList[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordsPairs.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        // ignore: dead_code
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordsPairs.remove(pair);
            } else {
              _savedWordsPairs.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedWordsPairs.map(
            (WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase,
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Beloved Words'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordpair"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list_rounded),
            onPressed: () {
              _pushSaved();
            },
          )
        ],
      ),
      body: _buildList(),
    );
  }
}
