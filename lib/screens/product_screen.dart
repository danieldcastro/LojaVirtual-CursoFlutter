import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  String sizes;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              boxFit: BoxFit.contain,
              dotSize: 10,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              dotIncreasedColor: Colors.lime,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: product.sizes.map(
                        (size) {
                          return GestureDetector (
                            onTap: () {
                              setState(() {
                                sizes = size;
                              });
                            },
                            child: Container (
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  color: size == sizes ? primaryColor : Colors.lime,
                                  width: 3
                                ),
                              ),
                              width: 500,
                              alignment: Alignment.center,
                              child: Text (size),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox (
                  height: 16,
                ),
                SizedBox (
                  height: 44,
                  child: RaisedButton (
                    onPressed: sizes != null ?
                    () {
                      if (UserModel.of(context).isLoggedIn()) {
                       CartProduct cartProduct = CartProduct();
                       cartProduct.size = sizes;
                       cartProduct.quantity = 1;
                       cartProduct.pid = product.id;
                       cartProduct.category = product.category;
                       cartProduct.productData =product;

                        CartModel.of(context).addCartItem(cartProduct);
                       Navigator.of(context).push (
                           MaterialPageRoute(builder: (context) => CartScreen())
                       );
                      } else {
                        Navigator.of(context).push (
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text (UserModel.of(context).isLoggedIn() ? 'Adicionar ao Carrinho'
                    : "Entre para Comprar",
                      style: TextStyle (fontSize: 18),),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                Divider(
                  height: 40,
                  color: Colors.lime,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text (
                    'Descrição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Text (product.description, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
