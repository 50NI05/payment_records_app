import 'package:flutter/material.dart';

import 'app_config.dart';
import 'my_app.dart';

void main() async {
  AppConfig.instance.init(
    nameApp: 'ControlPagos',
    // apiHost: 'http://10.0.2.2:3000/api/', // EMULADOR
    // apiHost: 'http://172.16.90.124:3000/api/' // TELÉFONO
    apiHost: 'https://payment-records-api-dygy-dev.fl0.io/api/'
  );

  runApp(const MyApp());
}
