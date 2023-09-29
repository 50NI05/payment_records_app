// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';

import '../../../../widgets/global_alert_options.dart';
import '../../../../widgets/global_loading.dart';

class AddPaymentButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const AddPaymentButton(
    this._scaffoldKey, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddPaymentButton> createState() => _AddPaymentButtonState();
}

class _AddPaymentButtonState extends State<AddPaymentButton> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPaymentController>(
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
                    final AddPaymentModel? result = await model.addPayment();
                    Navigator.of(context).pop();
                    if (result != null) {
                      if (result.status == 'SUCCESS') {
                        paymentAdded(context, result.data);
                      } else if (result.status == 'Error') {
                        showAlertOptions(
                          context,
                          title: 'Importante',
                          msg: result.data,
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
        child: const Text('Aceptar'),
      ),
    );
  }

  Future<void> paymentAdded(
    BuildContext context,
    String msg,
  ) async {
    showAlertOptions(
      context,
      title: 'Importante',
      msg: msg,
    );

    setState(() {
      final controller =
          Provider.of<AddPaymentController>(context, listen: false);

      controller.nameController.clear();
      controller.identityCardController.clear();
      controller.phoneNumberController.clear();
      controller.apartmentController.clear();
      controller.referenceCodeController.clear();
      controller.amountController.clear();
    });
  }
}
