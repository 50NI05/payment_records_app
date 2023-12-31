import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../routes/routes.dart';

class GoRegistePagerButton extends StatelessWidget {
  const GoRegistePagerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.REGISTER);
        },
        child: const Text('Registrate'));
  }
}
