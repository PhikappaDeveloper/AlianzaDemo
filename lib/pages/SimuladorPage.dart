import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_alianzademo/pages/ResumenSimuladorPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SimuladorPage extends StatefulWidget {
  @override
  _SimuladorPageState createState() => _SimuladorPageState();
}

class _SimuladorPageState extends State<SimuladorPage> {
  double _currentPrestamoValue = 1000;
  double _currentPagoValue = 100;
  String _currentFechaValue = "";

  final storage = new FlutterSecureStorage();
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es');
    _currentFechaValue = DateFormat.yMMMMd('es').format(now);
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
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("Calculemos",
                                  style: Theme.of(context).textTheme.headline4),
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                  "Usa este Simulador Para Entender Como Podria ser tu Prestamo",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("Si tu Prestamo es de",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'es_419', decimalDigits: 2)
                                      .format(_currentPrestamoValue.round()),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent)),
                            ),
                          ),
                          Slider(
                            value: _currentPrestamoValue,
                            max: 6000,
                            divisions: 60,
                            label: _currentPrestamoValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentPrestamoValue = value;

                                int diff = value ~/ _currentPagoValue;

                                var semana = now.add(Duration(days: diff * 7));
                                _currentFechaValue =
                                    DateFormat.yMMMMd('es').format(semana);
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text('Te Sugiero Pagar',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                  NumberFormat.simpleCurrency(
                                              locale: 'es_419',
                                              decimalDigits: 2)
                                          .format(_currentPagoValue.round()) +
                                      " por Semana",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent)),
                            ),
                          ),
                          Slider(
                            value: _currentPagoValue,
                            max: 2000,
                            divisions: 20,
                            label: _currentPagoValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentPagoValue = value;
                                int diff = _currentPrestamoValue ~/ value;

                                var semana = now.add(Duration(days: diff * 7));
                                _currentFechaValue =
                                    DateFormat.yMMMMd('es').format(semana);
                              });
                            },
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text('Asi Terminas de Pagar el',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(_currentFechaValue,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent)),
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text('A una Tasa de Interes anual',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text('30%',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent)),
                            ),
                          ),
                          SizedBox(height: 30),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledColor: Colors.grey,
                              elevation: 0,
                              color: Colors.blueAccent,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 15),
                                  child: Text(
                                    'SIGUIENTE',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () async {
                                await storage.write(
                                    key: 'prestamo',
                                    value: _currentPrestamoValue.toString());
                                await storage.write(
                                    key: 'pago',
                                    value: _currentPagoValue.toString());
                                await storage.write(
                                    key: 'fecha_prestamo',
                                    value: _currentFechaValue.toString());

                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new ResumenSimuladorPage()));
                              }),
                        ],
                      )),
                ],
              ),
            )));
  }
}
