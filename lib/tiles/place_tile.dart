import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Image.network(snapshot.data['image'], fit: BoxFit.cover),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      snapshot.data['title'],
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['address'],
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Ver no Mapa'),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    launch('https://www.google.com/maps/search/?api=1&query='
                        '${snapshot.data['lat']}, ${snapshot.data['long']}');
                  },
                ),
                FlatButton(
                  child: Text('Ligar'),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    launch('tel: ${snapshot.data['phone']}');
                  },
                )
              ],
            )
          ],
        ));
  }
}
