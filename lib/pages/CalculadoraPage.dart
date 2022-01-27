import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_alianzademo/pages/ResumenCalculadoraPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CalculadoraPage extends StatefulWidget {
  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  double _currentMetaValue = 100;

  TextEditingController ahorroController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  DateTime now = DateTime.now();
  String _currentFechaValue = "";

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es');
    ahorroController.text = '50';
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
                child: Form(
              key: _formKey,
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
                                  "Usa este Simulador para establecer tu meta de ahorro. Si no tienes en mente una cantidad, el 10% de tus ingresos suele ser una buena meta",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text("¿Cual es su meta total de ahorro?",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'es_419', decimalDigits: 2)
                                      .format(_currentMetaValue.round()),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow[700])),
                            ),
                          ),
                          Slider(
                            value: _currentMetaValue,
                            max: 2000,
                            divisions: 20,
                            activeColor: Colors.yellow[700],
                            label: _currentMetaValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentMetaValue = value;

                                int diff = value ~/
                                    double.parse(ahorroController.text);

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
                              child: Text('¿Cuanto puedes ahorrar a la semana?',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Focus(
                            child: TextFormField(
                              controller: ahorroController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  fillColor: Colors.white70),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Falta ingresa el ahorro por semana';
                                }
                              },
                            ),
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                setState(() {
                                  int diff = _currentMetaValue ~/
                                      double.parse(ahorroController.text);

                                  var semana =
                                      now.add(Duration(days: diff * 7));
                                  _currentFechaValue =
                                      DateFormat.yMMMMd('es').format(semana);
                                });
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text('Asi Cumples tu ahorro el',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(_currentFechaValue,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow[700])),
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
                                    'SIGUIENTE',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await storage.write(
                                      key: 'meta',
                                      value: _currentMetaValue.toString());
                                  await storage.write(
                                      key: 'ahorro',
                                      value: ahorroController.text);
                                  await storage.write(
                                      key: 'fecha',
                                      value: _currentFechaValue.toString());

                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new ResumenCalculadoraPage()));
                                }
                              }),
                        ],
                      )),
                ],
              ),
            ))));
  }
}
