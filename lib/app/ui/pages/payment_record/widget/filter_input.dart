import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_controller.dart';

import '../../../../widgets/global_input.dart';

class FilterInput extends StatelessWidget {
  const FilterInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PaymentRecordController>(context);

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          GlobalInput(
            controller: controller.filterController,
            keyboardType: TextInputType.text,
            focusNode: controller.filterFocusNode,
            placeholder: 'Filtro',
            maxLength: 30,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 2.5, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => {controller.filter()},
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  )),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 2.5, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => {controller.getAllPayment()},
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
