import 'package:flutter/material.dart';
import 'package:registro_pagos/app/ui/routes/routes.dart';

import '../../../theme/theme.dart';
import '../../../widgets/global_alert.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color.fromRGBO(234, 238, 242, 1),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      showAlert(context,
                          logout: true,
                          title: 'importante',
                          msg: '¿Está seguro que desea cerrar sesión?');
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                                child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    // margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(payment),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onTap: () => {
                                    Navigator.pushNamed(
                                        context, Routes.ADD_PAYMENT),
                                  },
                                ),
                              ],
                            )),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  'Agregar registro de pagos garantiza un seguimiento preciso y organizado de las transacciones',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.ADD_PAYMENT);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(234, 238, 242, 1),
                            minimumSize: const Size(40, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Pago',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Ver registros de pago proporciona un historial detallado de transacciones y facilita el seguimiento financiero.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(record),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.pushNamed(
                                        context, Routes.PAYMENT_RECORD),
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.PAYMENT_RECORD);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(40, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Registro',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
