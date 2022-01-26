import 'package:flutter/material.dart';
import 'package:app_alianzademo/functions/helpers.dart';
import 'package:app_alianzademo/pages/MetasPage.dart';
import 'package:app_alianzademo/pages/InitPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return  WillPopScope(
       onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(''),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: MenuLateral(),
            body: ListView(
            children: <Widget>[
              //cardPerfil(),
              SizedBox( height: 30 ),
              cardMetas(context),
              SizedBox( height: 30 ),
              cardCuentas(context),
            ],
      )));
  }
}

class MenuLateral extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: <Widget>[
           UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/logo.png"),
                fit: BoxFit.cover
              )
            ),
          ),
           ListTile(
            title: Text("Cerrar Sesion", style: TextStyle( fontSize: 18, color: Colors.black87 )),
            onTap: (){
              helpers.Logout().then((result) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => InitPage()),
                  (_) => false,
                );
              });
            },
          ),
                 ],
      ) ,
    );
  }
}

Card cardCuentas(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text('Mis Cuentas', style: TextStyle( fontSize: 20, color: Colors.black87 )),
            ),
            new Image.asset(
              'asset/images/ic_tour_5.png',
              width: 100.0,
              height: 100.0,
            ),
        ],
      )
    );
}

Card cardMetas(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new MetasPage())
                 );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text('Mis Metas', style: TextStyle( fontSize: 20, color: Colors.black87 )),
              ),
            new Image.asset(
              'asset/images/ic_about_5.png',
              width: 100.0,
              height: 100.0,
            ),
          ],
        ))
    );
}

  Card cardPerfil() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 5,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Image.asset(
                      'asset/images/profile.png',
                      width: 100.0,
                      height: 100.0,
                  ),
              Container(
                    padding: EdgeInsets.all(5),
                    child: Text('Hola, Fernando', style: TextStyle( fontSize: 20, color: Colors.black87 )),
                ),
            ],
        )
      );
  }
