import 'package:registro_pagos/app/data/providers/login_api.dart';
import 'package:registro_pagos/app/ui/pages/login/logout_model.dart';

import '../ui/pages/login/login_model.dart';

class LoginImpl implements LoginApi {
  final LoginApi _loginApi;

  LoginImpl(this._loginApi);

  @override
  Future<LoginModel> login({
    required String username,
    required String password,
  }) {
    return _loginApi.login(username: username, password: password);
  }

  @override
  Future<LogoutModel?>? logout({
    required int idUser,
    required String token,
  }) {
    return _loginApi.logout(idUser: idUser, token: token);
  }

  @override
  void cancel() {
    _loginApi.cancel();
  }

  @override
  void dispose() {
    _loginApi.dispose();
  }

  @override
  Stream<List<LoginModel>?> get onResults => _loginApi.onResults;
}
