// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/widgets/add_payment_button.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/widgets/add_payment_inputs.dart';

import '../../../data/providers/add_payment_api.dart';
import '../../../widgets/global_alert.dart';

class AddPaymentPage extends StatelessWidget {
  final String name, apartment;
  final String identity_card, phone_number, reference_number;
  final String amount;

  AddPaymentPage({
    Key? key,
    required this.name,
    required this.identity_card,
    required this.phone_number,
    required this.apartment,
    required this.reference_number,
    required this.amount,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AddPaymentController>(
            create: (_) {
              return AddPaymentController(
                AddPaymentApi(Dio()),
                name: name,
                identity_card: identity_card,
                phone_number: phone_number,
                apartment: apartment,
                reference_number: reference_number,
                amount: amount,
              );
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(234, 238, 242, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            elevation: 0,
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      showAlert(
                        context,
                        logout: true,
                        title: 'importante',
                        msg: '¿Está seguro que desea cerrar sesión?',
                      );
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
            title: const Text(
              'Pago',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          key: _scaffoldKey,
          body: Stack(
            children: [
              Positioned(
                height: 150,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      color: Colors.blue,
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: const Text(
                        'Ingresa los datos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Column(
                          children: [
                            const AddPaymentInput(),
                            AddPaymentButton(_scaffoldKey),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
