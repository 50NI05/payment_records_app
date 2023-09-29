import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/go_register_page_button.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/login_button.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/login_inputs.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/logo_login.dart';
import '../../../data/login_impl.dart';
import '../../../data/providers/login_api.dart';
import '../login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final String username, password;

  LoginPage({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //checkLogin(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginController>(
            create: (_) {
              return LoginController(
                LoginImpl(
                  LoginApi(Dio()),
                ),
                username: username,
                password: password,
              );
            },
          ),
        ],
        child: Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.blue,
              body: Stack(
                children: [
                  Transform.scale(
                    scale: 1.6,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(234, 238, 242, 1),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LoginLogo(),
                          Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black.withOpacity(0.7)
                            ),
                          ),
                          const LoginInputs(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LoginButton(_scaffoldKey),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // const Text('¿Has olvidado tu contraseña?'),
                          // const SizedBox(height: 15),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 16.0, right: 16.0),
                          //   child: Container(
                          //     color: Colors.black,
                          //     height: 1,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // const GoRegistePagerButton()
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
