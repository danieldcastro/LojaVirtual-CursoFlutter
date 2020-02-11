import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text (
          'Pedido Realizado',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container (
          padding: EdgeInsets.all(16),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon (Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 80,),
              Text ('Pedido realizado com sucesso!',
              style: TextStyle (fontWeight: FontWeight.bold, fontSize: 20)),
              Text ('Código do pedido: $orderId',
              style: TextStyle (fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
