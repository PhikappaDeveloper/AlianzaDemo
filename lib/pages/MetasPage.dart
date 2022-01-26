import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_alianzademo/models/meta.dart';
import 'package:app_alianzademo/pages/SimuladorPage.dart';
import 'package:app_alianzademo/pages/CalculadoraPage.dart';
import 'package:app_alianzademo/pages/DetallesMetasPage.dart';
import 'package:app_alianzademo/pages/DetallesSimuladorPage.dart';
import 'package:app_alianzademo/database/meta.dart';
import 'package:app_alianzademo/database/prestamo.dart';


class MetasPage extends StatefulWidget {
  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  
  @override
  void initState(){
    super.initState();
  }

  void _showModalBottomSheet(BuildContext context,String type, int id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: new Icon(Icons.remove_red_eye_outlined),
                title: new Text('Ver Detalles'),
                onTap: () {

                  if(type == "Meta"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetallesMetasPage(id: id),
                      ),
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetallesSimuladorPage(id: id),
                      ),
                    );
                  }
                  
                },
              ),
              ListTile(
                leading: new Icon(Icons.delete),
                title: new Text('Eliminar'),
                onTap: () async {
                  setState(() {
                    if(type == "Meta"){
                      meta.deleteItem(id);
                    }else{
                      prestamo.deleteItem(id);
                    }
                    
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }

  ListView _metasListView(data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.5,
            child: ListTile(
                title: Text(NumberFormat.simpleCurrency(locale: 'es_419',decimalDigits: 2).format(double.parse(data[index]['meta'])),
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.yellow[700]
                    )),
                subtitle: Text("Meta", style: TextStyle(color: Colors.yellow[700])),
                leading: Image.asset('asset/images/ic_empty_goals.png', width: 100.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => {
                    _showModalBottomSheet(context,"Meta",data[index]['id'])
                }  
                ),
          );
        });
  }

  ListView _prestamoListView(data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.5,
            child: ListTile(
                title: Text(NumberFormat.simpleCurrency(locale: 'es_419',decimalDigits: 2).format(double.parse(data[index]['prestamo'])),
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blueAccent
                    )),
                subtitle: Text("Prestamo", style: TextStyle(color: Colors.blueAccent)),
                leading: Image.asset('asset/images/ic_balance.png', width: 100.0),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () =>  {
                  _showModalBottomSheet(context,"Prestamo",data[index]['id'])
                }
                ),
          );
        });
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
                SizedBox( height: 10 ),
                 Container(
                  padding: EdgeInsets.all( 10 ),
                  child: Column(
                    children: <Widget>[

                      SizedBox( height: 10 ),

                      Text('Mis Metas', style: Theme.of(context).textTheme.headline4 ),

                      SizedBox( height: 10 ),

                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: meta.getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Map<String, dynamic>>? data = snapshot.data;
                            return _metasListView(data);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return new Container(
                            height: 20.0,
                          );
                        },
                      ),

                      SizedBox( height: 10 ),

                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: prestamo.getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Map<String, dynamic>>? data = snapshot.data;
                            return _prestamoListView(data);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return new Container(
                            height: 20.0,
                          );
                        },
                      ),

                      SizedBox( height: 30 ),

                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.yellow[700],
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              new Image.asset(
                              'asset/images/ic_add_loan.png',
                              width: 40.0,
                              height: 40.0,
                              ),
                              SizedBox( width: 30 ),
                              Text(
                                'AGREGAR META',
                                style: TextStyle( color: Colors.white, fontSize: 16 ),
                              )
                            ] 
                          )
                        ),
                        onPressed: () async {
                          Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new CalculadoraPage())
                          );
                        }
                      ),

                      SizedBox( height: 10 ),

                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.blueAccent,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              new Image.asset(
                              'asset/images/ic_add.png',
                              width: 40.0,
                              height: 40.0,
                              ),
                              SizedBox( width: 30 ),
                              Text(
                                'SIMULADOR PRESTAMO',
                                style: TextStyle( color: Colors.white, fontSize: 16 ),
                              )
                            ] 
                          )                          
                        ),
                        onPressed: () async {
                          Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new SimuladorPage())
                          );
                        }
                      )
                    ],
                  )
          )])),
             
        ));
  }
}


