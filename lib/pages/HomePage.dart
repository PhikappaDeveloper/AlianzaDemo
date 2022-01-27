import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_alianzademo/services/auth.dart';
import 'package:app_alianzademo/pages/MetasPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(''),
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset("asset/images/icon.png",
                    height: 550, width: 650),
              ),
              elevation: 2.0,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    auth.logout();
                    Navigator.pushReplacementNamed(context, 'init');
                  },
                ),
              ],
            ),
            //drawer: MenuLateral(),
            body: ListView(
              children: <Widget>[
                //cardPerfil(),
                SizedBox(height: 30),
                cardMetas(context),
                SizedBox(height: 30),
                cardCuentas(context),
              ],
            )));
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
            child: Text('Mis Cuentas',
                style: TextStyle(fontSize: 20, color: Colors.black87)),
          ),
          Image.asset(
            'asset/images/ic_tour_5.png',
            width: 100.0,
            height: 100.0,
          ),
        ],
      ));
}

Card cardMetas(BuildContext context) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new MetasPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text('Mis Metas',
                    style: TextStyle(fontSize: 20, color: Colors.black87)),
              ),
              new Image.asset(
                'asset/images/ic_about_5.png',
                width: 100.0,
                height: 100.0,
              ),
            ],
          )));
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
            child:
                Text('', style: TextStyle(fontSize: 20, color: Colors.black87)),
          ),
        ],
      ));
}
