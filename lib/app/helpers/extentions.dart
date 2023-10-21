extension extString on String {
  bool get isValidUsername {
    final nameRegExp = RegExp(r'^[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*$');
    // final nameRegExp = RegExp(
    //     r'^(([a-zA-Z0-9]([\.\-\_]){1})|([a-zA-Z0-9]))+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4}|[a-zA-Z]{1,3}\.[a-zA-Z]{1,3})$');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[0-9])(?=.*[.,#-])(?=.*[A-Z])(?=.*[a-z])[a-zA-Z0-9.,#-]{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'^(?!.*\s$)[a-zA-Z ]+$');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidNumber {
    final numberRegExp = RegExp(r'^[0-9]+$');
    return numberRegExp.hasMatch(this);
  }

  bool get isValidate {
    final special = RegExp(r'^[a-zA-Z0-9-]+$');
    return special.hasMatch(this);
  }

  bool get isValidDecimal {
    final decimalRegExp = RegExp(r'^[0-9]+([.][0-9]+)?$');
    return decimalRegExp.hasMatch(this);
  }

  // En caso de no esta vacio retorna null
  bool get isNotNull {
    return this != null;
  }
}
