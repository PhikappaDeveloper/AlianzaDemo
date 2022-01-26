import 'package:flutter/material.dart';
import 'package:app_alianzademo/pages/HomePage.dart';
import 'package:app_alianzademo/ui/input_decorations.dart';
import 'package:app_alianzademo/database/user.dart';
import 'package:app_alianzademo/models/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  bool isLoading = false;
  
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
                padding: EdgeInsets.all( 40 ),
                child: Column(
                  children: [
                    new Image.asset(
                            'asset/images/ic_coin_login.png',
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                    ),
                    SizedBox( height: 10 ),
                    //Text('Iniciar', style: Theme.of(context).textTheme.headline4 ),
                    Text('Inicia sesion para continuar, Ingresa tu numero de telefono', style: TextStyle( fontSize: 14, color: Colors.black87 ) ),
                    SizedBox( height: 30 ),
                    _LoginForm()
                  ],
                )
              ),
            ],
          ),
        )
      ));
  }
}

class _LoginForm extends StatelessWidget {

final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) { 

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Telefono',
                prefixIcon: Icons.phone_android
              ),
              validator: ( value ) {
                  if (value != null && value.isEmpty) {
                    return 'Falta ingresar el Telefono';
                  }
              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              controller: passwordController,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              validator: ( value ) {
                  if (value != null && value.isEmpty) {
                    return 'Falta ingresar la contraseña';
                  }                    
              },
            ),

            SizedBox( height: 20 ),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueAccent,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: () async {
                
                if (_formKey.currentState!.validate()) {
                  final data = User(
                    id : "1", 
                    username: nameController.text, 
                    password: passwordController.text,
                  );
                  
                  await user.insert(data);

                  Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new HomePage())
                  );
                }
              }
            )

          ],
        ),
      ),
    );
  }
}

