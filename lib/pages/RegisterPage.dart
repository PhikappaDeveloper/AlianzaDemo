import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_alianzademo/providers/loginProvider.dart';
import 'package:app_alianzademo/services/auth.dart';
import 'package:app_alianzademo/services/notifications.dart';
import 'package:app_alianzademo/ui/input_decorations.dart';

class RegisterPage extends StatelessWidget {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/ic_about_1.png',
                            width: 200.0,
                            height: 250.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          //Text('Iniciar', style: Theme.of(context).textTheme.headline4 ),
                          Text('Registrate con tu Correo Electronico',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                          SizedBox(height: 30),
                          ChangeNotifierProvider(
                              create: (_) => loginProvider(),
                              child: _RegisterForm())
                        ],
                      )),
                ],
              ),
            )));
  }
}

class _RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<loginProvider>(context);

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Correo Electronico',
                  prefixIcon: Icons.email),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Falta ingresar el Email';
                }
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: passwordController,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser de mas de 6 caracteres';
              },
            ),
            SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.blueAccent,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Cargando...' : 'Guardar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loginForm.isLoading = true;

                    FocusScope.of(context).unfocus();
                    final auth = Provider.of<Auth>(context, listen: false);

                    final String? errorMessage = await auth.Register(
                        loginForm.email, loginForm.password);

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      Notifications.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
