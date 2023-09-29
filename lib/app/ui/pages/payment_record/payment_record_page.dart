import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/data/providers/delete_payment_api.dart';
import 'package:registro_pagos/app/data/providers/get_all_payment_api.dart';
import 'package:registro_pagos/app/data/providers/update_payment_api.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/delete_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/update_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/widget/filter_input.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_controller.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_table.dart';

import '../../../theme/theme.dart';
import '../../../widgets/global_alert.dart';

class PaymentRecordPage extends StatelessWidget {
  const PaymentRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PaymentRecordController>(
            create: (_) {
              return PaymentRecordController(
                GetAllPaymentApi(Dio()),
              );
            },
          ),
          ChangeNotifierProvider<DeletePaymentController>(
            create: (_) {
              return DeletePaymentController(
                DeletePaymentApi(Dio()),
              );
            },
          ),
          ChangeNotifierProvider<UpdatePaymentController>(
            create: (_) {
              return UpdatePaymentController(
                UpdatePaymentApi(Dio()),
              );
            },
          ),
        ],
        builder: (context, __) {
          final allPaymentcontroller =
              Provider.of<PaymentRecordController>(context);
          final deletePaymentController =
              Provider.of<DeletePaymentController>(context);
          final updatePaymentController =
              Provider.of<UpdatePaymentController>(context);
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.blue,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromRGBO(234, 238, 242, 1),
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
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                  title: const Text(
                    'Registro',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                body: Stack(
                  children: [
                    Positioned(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(234, 238, 242, 1),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 45.0,
                            left: 20,
                          ),
                          child: Text(
                            'Historial de Registros',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 150),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            children: [
                              Card(
                                color: const Color.fromRGBO(234, 238, 242, 1),
                                child: Column(
                                  children: [
                                    const FilterInput(),
                                    PaymentRecordTable(
                                      allPaymentcontroller:
                                          allPaymentcontroller,
                                      deletePaymentController:
                                          deletePaymentController,
                                      updatePaymentController:
                                          updatePaymentController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (allPaymentcontroller.isLoading)
                Container(
                  color: Colors.white54,
                  child: WillPopScope(
                    onWillPop: () async => false,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
