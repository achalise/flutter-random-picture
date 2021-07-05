import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();

}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _dynaListView() => ListView.builder(
    itemBuilder: (context, item) {
      if(item.isOdd) {
        return Divider();
      }
      final index = item ~/ 2;

      if(index >= _randomWordPairs.length) {
        _randomWordPairs.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_randomWordPairs[index]);
    },
  );

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border_outlined, 
      color: alreadySaved ? Colors.red[700]: null),
      onTap: (){
        setState(() {
          if(alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext buildContext) {
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
            return ListTile(title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
          } );

          final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

          return Scaffold(
            appBar: AppBar(title: Text("Saved words")),
            body: ListView(children: divided),
          );
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordpair Generator'),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ]),
      body: _dynaListView() //_buildList(),
    );
  }

}