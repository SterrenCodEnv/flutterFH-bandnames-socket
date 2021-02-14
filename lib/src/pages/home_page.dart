import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_name_app/src/models/band_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'The Weekns', votes: 12),
    Band(id: '2', name: 'Greg Holden', votes: 10),
    Band(id: '3', name: 'Ludovico Einaudi', votes: 8),
    Band(id: '4', name: 'Deep Focus', votes: 16),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
          elevation: 1, child: Icon(Icons.add), onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    String bandLetters = '';
    if (band.name.toString().contains(' ')) {
      List bandName = band.name.split(' ');
      for (var i = 0; i < bandName.length; i++) {
        var firstLetter = bandName[i].toString().substring(0, 1);
        bandLetters = bandLetters + firstLetter;
      }
    } else {
      bandLetters = band.name.toString().substring(0, 2);
    }

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        // TODO: Eliminar banda del backend.
        print('Dirección: $direction');
        print('Id: ${band.id}');
        this.bands.remove(band);
      },
      background: Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(width: 10),
            Text(
              'Delete ${band.name}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ]),
          color: Colors.red[400]),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            '$bandLetters',
            style: TextStyle(fontSize: (bandLetters.length < 3 ? 16 : 12)),
          ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    // Manipular valores ingresados en textfield
    final textEditing = new TextEditingController();

    // Verificar plataforma de equilo (Android o iOS)
    if (Platform.isAndroid) {
      // Para android
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New band name:'),
              content: TextField(
                controller: textEditing,
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    textColor: Colors.blue,
                    elevation: 5,
                    onPressed: () => addBandToList(textEditing.text))
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('New band name:'),
              content: CupertinoTextField(
                controller: textEditing,
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandToList(textEditing.text)),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.pop(context))
              ],
            );
          });
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      Band band = new Band();
      band.id = DateTime.now().toString();
      band.name = name;
      band.votes = Random().nextInt(20);
      this.bands.add(band);
      setState(() {});
    }
    Navigator.pop(context);
  }
}
