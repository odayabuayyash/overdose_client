validatorInputs(String? e, int max, int min, String validatorTypeName) {
  if (validatorTypeName == 'email') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة البريد الالكتروني فارغ';
    } else {
      if (e.length > max) {
        return 'البريد الالكتروني  لا يجب ان يتجاوز $max احرف';
      } else if (e.length < min) {
        return 'البريد الالكتروني  لا يمكن ان يكون اقل من $min احرف';
      } else {
        bool emailValid =
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(e);
        if (emailValid == false) {
          return 'يرجى ادخال بريد الكتروني صالح';
        }
      }
    }
  } else if (validatorTypeName == 'phone') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة رقم الهاتف فارغ';
    } else {
      if (e.length > max) {
        return 'رقم الهاتف لا يجب ان يتجاوز $max ارقام';
      } else if (e.length < min) {
        return 'رقم الهاتف لا يمكن ان يكون اقل من $min ارقام';
      }
    }
  } else if (validatorTypeName == 'username') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة الاسم فارغة';
    } else {
      if (e.length > max) {
        return ' الاسم لا يجب ان يتجاوز $max احرف';
      } else if (e.length < min) {
        return 'الاسم لا يمكن ان يكون اقل من $min احرف';
      }
    }
  } else if (validatorTypeName == 'password') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة كلمة المرور فارغ';
    } else {
      if (e.length > max) {
        return ' كلمة المرور لا يجب ان تتجاوز $max';
      } else if (e.length < min) {
        return 'كلمة المرور لا يمكن ان تكون اقل من $min';
      }
    }
  } else if (validatorTypeName == 'passwordLogin') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة كلمة المرور فارغ';
    } else {
      if (e.length < min) {
        return 'كلمة المرور لا يمكن ان تكون اقل من $min';
      }
    }
  } else if (validatorTypeName == 'location') {
    if (e!.isEmpty) {
      return 'لا يمكن ترك خانة الموقع فارغ';
    } else {
      if (e.length > max) {
        return 'الموقع لا يجب ان يتجاوز $max احرف';
      } else if (e.length < min) {
        return 'الموقع لا يمكن ان يكون اقل من $min احرف';
      }
    }
  }
}
