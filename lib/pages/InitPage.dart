import 'package:flutter/material.dart';
import 'package:app_alianzademo/pages/LoginPage.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox( height: 50 ),
              Container(
                padding: EdgeInsets.all( 40 ),
                child: Column(
                  children: [
                    Text('!Bienvenido!', style: Theme.of(context).textTheme.headline4 ),
                    new Image.asset(
                            'asset/images/ic_enter.png',
                            width: 300.0,
                            height: 300.0,
                    ),
                    SizedBox( height: 30 ),
                  ],
                )
              ),

              SizedBox( height: 5 ),
              
              Text('¿Ya Tienes Cuenta?', style: TextStyle( fontSize: 14, color: Colors.black87 ) ),
              SizedBox( height: 10 ),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.blueAccent,
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                  child: Text(
                    'Inicia Sesion',
                    style: TextStyle( color: Colors.white ),
                  )
                ),
                onPressed: () async {
                  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new LoginPage())
                 );
                }
              )
            ],
          ),
        )
      );
  }
}

