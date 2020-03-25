import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
//imported files
import 'package:shopapp/components/horizontal_listview.dart';
import 'package:shopapp/components/Products.dart';
import 'package:shopapp/pages/cart.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: true,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(microseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 1.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text('ShopApp'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Cart()));
              }),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header
            new UserAccountsDrawerHeader(
              accountName: Text('Iyiola Akanbi'),
              accountEmail: Text('iyiola.dev@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text('HomePage'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text('My Account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),

            InkWell(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => Cart()));
                },
                title: Text('My Shopping Cart'),
                leading: Icon(Icons.shopping_cart),
              ),
            ),

            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text('Favourite'),
                leading: Icon(Icons.favorite),
              ),
            ),
            Divider(),

            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),

            InkWell(
              child: ListTile(
                onTap: () {},
                title: Text(' About Us '),
                leading: Icon(
                  Icons.help,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          //images sliders
          imageCarousel,
          //padding
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('categories'),
          ),
          //HORIZONTAL LIST VIEW CLASS
          HorizontalList(),

          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text('Recent Products'),
          ),
          // grid view

          Container(
            height: 280.0,
            child: Products(),
          )
        ],
      ),
    );
  }
}