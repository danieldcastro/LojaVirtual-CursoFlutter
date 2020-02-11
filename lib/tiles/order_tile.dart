import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    print(_buildProductsText);
    return Card (
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {

                int status = snapshot.data['status'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Código do Pedido: ',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 17),
                        ),
                        Text(
                          snapshot.data.documentID,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 17, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_buildProductsText(snapshot.data), style: TextStyle(fontSize: 15)
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Divider(color: Colors.deepPurple,),

                    SizedBox(
                      height: 40,
                      child: Text(
                        'Status do Pedido: ',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildCircle('1', 'Preparação', status, 1),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 3,
                          width: 50,
                          color: Colors.lime,
                        ),
                        _buildCircle('2', 'Transporte', status, 2),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 3,
                          width: 50,
                          color: Colors.lime,
                        ),
                        _buildCircle('3', 'Entrega', status, 3),
                      ],
                    )
                  ],

                );
              }
            },
            stream: Firestore.instance
                .collection('orders')
                .document(orderId)
                .snapshots()),
      ),
    );
  }


  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n\n';
        for(LinkedHashMap p in snapshot.data['products']) {
          text += '${p['quantity']}x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
        }
        text += '\nTotal:  R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2) }';
        return text;
  }

  Widget _buildCircle(String title, String subTitle, int status, int thisStatus){
    Color backColor;
    Widget child;

    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    } else if (status == thisStatus) {
      backColor = Colors.deepPurple;
      child = Stack (
        alignment: Alignment.center,
        children: <Widget>[
          Text (title, style: TextStyle(color: Colors.lime)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lime),
            strokeWidth: 5,

          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 25,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
