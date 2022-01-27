import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_alianzademo/pages/HomePage.dart';
import 'package:app_alianzademo/database/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetallesMetasPage extends StatelessWidget {
  int? id;

  DetallesMetasPage({Key? key, @required this.id}) : super(key: key);

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
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: meta.getItem(id!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Map<String, dynamic>> data =
                                    snapshot.data!;
                                return _DetallesWidget(context, data);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Container(
                                height: 20.0,
                              );
                            },
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }

  Widget _DetallesWidget(
      BuildContext context, List<Map<String, dynamic>> data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/images/ic_empty_goals.png',
                    width: 130.0,
                    height: 150.0,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Detalles:",
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Si tu Ahorro es de:",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black87)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'es_419', decimalDigits: 2)
                                .format(double.parse(data[0]['meta'])),
                            style: TextStyle(
                                fontSize: 16, color: Colors.yellow[700]))),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Te Sugiero guardar:",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black87)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'es_419', decimalDigits: 2)
                                .format(double.parse(data[0]['ahorro'])),
                            style: TextStyle(
                                fontSize: 16, color: Colors.yellow[700]))),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Asi Cumples tu Ahorro el",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black87)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text(data[0]['fecha'],
                            style: TextStyle(
                                fontSize: 16, color: Colors.yellow[700]))),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
