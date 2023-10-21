// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/delete_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_controller.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/update_payment_controller.dart';
import 'package:registro_pagos/app/widgets/global_cupertino_input.dart';

import '../../../theme/theme.dart';
import '../../../widgets/global_alert_options.dart';

class PaymentRecordTable extends StatefulWidget {
  final PaymentRecordController allPaymentcontroller;
  final DeletePaymentController deletePaymentController;
  final UpdatePaymentController updatePaymentController;

  const PaymentRecordTable(
      {Key? key,
      required this.allPaymentcontroller,
      required this.deletePaymentController,
      required this.updatePaymentController})
      : super(key: key);

  @override
  State<PaymentRecordTable> createState() => _PaymentRecordTableState();
}

class _PaymentRecordTableState extends State<PaymentRecordTable> {
  Future? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = widget.allPaymentcontroller.getAllPayment();
  }

  @override
  Widget build(BuildContext context) {
    final allPaymentController = Provider.of<PaymentRecordController>(context);
    final deletePaymentController =
        Provider.of<DeletePaymentController>(context);
    final updatePaymentController =
        Provider.of<UpdatePaymentController>(context);

    final labels = [
      'ID',
      'Nombre Completo',
      'Cédula',
      'Teléfono',
      'Apart.',
      'Referencia',
      'Monto',
      'Fecha',
      'Acción'
    ];

    return FutureBuilder(
      future: _myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: List<DataColumn>.generate(
              labels.length,
              (index) => DataColumn(
                label: Text(
                  labels[index],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            rows: allPaymentController.filterPayment != null
                ? List<DataRow>.generate(
                    allPaymentController.filterPayment!.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            allPaymentController.filterPayment![index]!.id
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController.filterPayment![index]!.name
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController
                                .filterPayment![index]!.identityCard
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController
                                .filterPayment![index]!.phoneNumber
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController
                                .filterPayment![index]!.apartment
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController
                                .filterPayment![index]!.referenceNumber
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController.filterPayment![index]!.amount
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            allPaymentController
                                .filterPayment![index]!.paymentDate
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => {
                                  showAlertOptions(
                                    context,
                                    msg: '',
                                    title: 'Modificar Registro',
                                    msgWidget: Column(
                                      children: [
                                        GlobalCupertinoInput(
                                          placeholder: 'Nombre',
                                          focusNode: updatePaymentController
                                              .nameFocusNode,
                                          controller: updatePaymentController
                                              .nameController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 20,
                                          keyboardType: TextInputType.text,
                                        ),
                                        GlobalCupertinoInput(
                                          placeholder: 'Cédula',
                                          focusNode: updatePaymentController
                                              .identityCardFocusNode,
                                          controller: updatePaymentController
                                              .identityCardController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 8,
                                          keyboardType: TextInputType.number,
                                        ),
                                        GlobalCupertinoInput(
                                          placeholder: 'Teléfono',
                                          focusNode: updatePaymentController
                                              .phoneNumberFocusNode,
                                          controller: updatePaymentController
                                              .phoneNumberController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 11,
                                          keyboardType: TextInputType.number,
                                        ),
                                        GlobalCupertinoInput(
                                          placeholder: 'Apartamento',
                                          focusNode: updatePaymentController
                                              .aparmentFocusNode,
                                          controller: updatePaymentController
                                              .apartmentController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 5,
                                          keyboardType: TextInputType.text,
                                        ),
                                        GlobalCupertinoInput(
                                          placeholder: 'N° de Referencia',
                                          focusNode: updatePaymentController
                                              .referenceCodeFocusNode,
                                          controller: updatePaymentController
                                              .referenceCodeController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 12,
                                          keyboardType: TextInputType.number,
                                        ),
                                        GlobalCupertinoInput(
                                          placeholder: 'Monto',
                                          focusNode: updatePaymentController
                                              .amountFocusNode,
                                          controller: updatePaymentController
                                              .amountController,
                                          labelStyle: Colors.black,
                                          colorStyle: Colors.black,
                                          borderSide: Colors.black,
                                          maxLength: 5,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                    acceptTitle: 'Aceptar',
                                    acceptOnPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                CircularProgressIndicator(),
                                                SizedBox(height: 16),
                                                Text('Actualizando datos...'),
                                              ],
                                            ),
                                          );
                                        },
                                        barrierDismissible:
                                            false, // Evita que el usuario cierre el diálogo
                                      );

                                      await updatePaymentController.updatePayment(allPaymentController.filterPayment![index]!.id,
                                          name: updatePaymentController.nameController.text != ''
                                              ? updatePaymentController
                                                  .nameController.text
                                              : allPaymentController.filterPayment![index]!.name
                                                  .toString(),
                                          identity_card: updatePaymentController.identityCardController.text != ''
                                              ? updatePaymentController.identityCardController.text
                                                  .toString()
                                              : allPaymentController
                                                  .filterPayment![index]!
                                                  .identityCard
                                                  .toString(),
                                          phone_number: updatePaymentController.phoneNumberController.text != ''
                                              ? updatePaymentController.phoneNumberController.text
                                                  .toString()
                                              : allPaymentController
                                                  .filterPayment![index]!
                                                  .phoneNumber
                                                  .toString(),
                                          apartment: updatePaymentController.apartmentController.text != ''
                                              ? updatePaymentController.apartmentController.text.toString()
                                              : allPaymentController.filterPayment![index]!.apartment.toString(),
                                          reference_number: updatePaymentController.referenceCodeController.text != '' ? updatePaymentController.referenceCodeController.text.toString() : allPaymentController.filterPayment![index]!.referenceNumber.toString(),
                                          amount: updatePaymentController.amountController.text != '' ? updatePaymentController.amountController.text.toString() : allPaymentController.filterPayment![index]!.amount.toString());
                                      updatePaymentController.nameController
                                          .clear();
                                      updatePaymentController
                                          .identityCardController
                                          .clear();
                                      updatePaymentController
                                          .phoneNumberController
                                          .clear();
                                      updatePaymentController
                                          .apartmentController
                                          .clear();
                                      updatePaymentController
                                          .referenceCodeController
                                          .clear();
                                      updatePaymentController.amountController
                                          .clear();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      await allPaymentController
                                          .getAllPayment();
                                    },
                                    cancelTitle: 'Cancelar',
                                    cancelOnPressed: () =>
                                        {Navigator.pop(context)},
                                  ),
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              CircularProgressIndicator(
                                                color: primaryColor,
                                              ),
                                              SizedBox(width: 20),
                                              Text('Eliminando...'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  await deletePaymentController.deletePayment(
                                    allPaymentController
                                        .filterPayment![index]!.id,
                                  );

                                  Navigator.pop(context);

                                  await allPaymentController.getAllPayment();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const [
                    DataRow(
                      cells: [
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                        DataCell(Text('N/A'), placeholder: true),
                      ],
                    ),
                  ],
          ),
        );
      },
    );
  }
}
