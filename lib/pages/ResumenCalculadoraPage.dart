import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_alianzademo/pages/HomePage.dart';
import 'package:app_alianzademo/database/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResumenCalculadoraPage extends StatefulWidget {
  @override
  _ResumenCalculadoraPageState createState() => _ResumenCalculadoraPageState();
}

class _ResumenCalculadoraPageState extends State<ResumenCalculadoraPage> {
  final storage = new FlutterSecureStorage();
  String? metas = "";
  String? ahorro = "";
  String? fecha = "";

  @override
  void initState() {
    super.initState();
    initStorage();
    initializeDateFormatting('es');
  }

  void initStorage() async {
    storage.read(key: 'meta').then((value) => metas = value);
    storage.read(key: 'ahorro').then((value) => ahorro = value);
    storage.read(key: 'fecha').then((value) => fecha = value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                Navigator.pop(context, false);
              },
            )),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Image.asset(
                            'asset/images/ic_calculate.png',
                            width: 250.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("En Resumen:",
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                          ),
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("Si tu Ahorro es de:",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: FutureBuilder<String?>(
                                  future: storage.read(key: 'meta'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: 'es_419',
                                                  decimalDigits: 2)
                                              .format(
                                                  double.parse(snapshot.data!)),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.yellow[700]));
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return new Container(
                                      height: 20.0,
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("Te Sugiero guardar:",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: FutureBuilder<String?>(
                                  future: storage.read(key: 'ahorro'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: 'es_419',
                                                  decimalDigits: 2)
                                              .format(
                                                  double.parse(snapshot.data!)),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.yellow[700]));
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return new Container(
                                      height: 20.0,
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("Asi Cumples tu Ahorro el",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: FutureBuilder<String?>(
                                  future: storage.read(key: 'fecha'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.yellow[700]));
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return new Container(
                                      height: 20.0,
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 30),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledColor: Colors.grey,
                              elevation: 0,
                              color: Colors.yellow[700],
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 15),
                                  child: Text(
                                    'ACEPTAR',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () async {
                                await meta.createItem(
                                  metas,
                                  ahorro,
                                  fecha,
                                );

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (_) => false,
                                );
                              }),
                        ],
                      )),
                ],
              ),
            )));
  }
}
