// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/global_alert_options.dart';
import '../../../../widgets/global_loading.dart';
import '../../../routes/routes.dart';
import '../login_controller.dart';
import '../login_model.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const LoginButton(
    this._scaffoldKey, {
    Key? key,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, model, child) => CupertinoButton(
        disabledColor: Colors.blue.withOpacity(0.4),
        pressedOpacity: 1,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        onPressed: (!model.validate)
            ? null
            : () async {
                globalLoading(context);
                if (!_buttonPressed) {
                  try {
                    _buttonPressed = true;
                    FocusScope.of(context).unfocus();
                    final LoginModel? result = await model.submitData();
                    Navigator.of(context).pop();
                    if (result != null) {
                      if (result.status == 'SUCCESS') {
                        loginSuccess(context, result.data, result.id);
                      } else if (result.status == 'Error') {
                        showAlertOptions(
                          context,
                          title: 'Importante',
                          msg: 'Usuario y/o contraseña incorrecta.',
                        );
                      }
                    } else {
                      showAlertOptions(
                        context,
                        title: 'Importante',
                        msg:
                            'Disculpe, en estos momentos no hay conexión a internet',
                      );
                    }
                    _buttonPressed = false;
                  } catch (e) {
                    Navigator.of(context).pop();
                    if (e == "Connection refused") {
                      showAlertOptions(
                        context,
                        msg: "Error del servidor",
                        title: 'Importante',
                      );
                    } else {
                      showAlertOptions(
                        context,
                        msg:
                            'Disculpe, en estos momentos no hay conexión a internet',
                        title: 'Importante',
                      );
                    }
                    _buttonPressed = false;
                  }
                }
              },
        child: const Text('Continuar'),
      ),
    );
  }

  Future<void> loginSuccess(
    BuildContext context,
    String token,
    int? idUser,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final controller = Provider.of<LoginController>(context, listen: false);
    await prefs.setString('username', controller.usernameController.text);
    await prefs.setString('password', controller.passwordController.text);
    await prefs.setString('token', token);
    await prefs.setInt('idUser', idUser!);
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    debugPrint(
        'validateBurtton username: $username - password: $password - idUser: $idUser');

    Navigator.of(context).pushNamed(Routes.HOME);
  }
}
