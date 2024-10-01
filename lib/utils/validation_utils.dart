import '../api/exception/app_exception.dart';
import 'app_string.dart';

class AppValidation {
  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterName;
    }
    return null;
  }

  static String? lastNameValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterLastName;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    const Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final RegExp regex = RegExp(pattern.toString());
    if (value!.isEmpty) {
      return AppString.pleaseEnterEmail;
    } else if (!regex.hasMatch(value)) {
      return AppString.emailAddressIsInvalid;
    } else {
      return null;
    }
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterPassword;
    } else if (value.length <= 6) {
      return AppString.passwordCodeMustBeDigits;
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword) {
    if (confirmPassword!.isEmpty) {
      return AppString.pleaseEnterPassword;
    } else if (confirmPassword.length <= 6) {
      return AppString.passwordCodeMustBeDigits;
    } else if (confirmPassword != password.toString()) {
      return AppString.bothPasswordNotMatch;
    }
    return null;
  }

  static String? postCode(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterPostCode;
    } else if (value.length != 6) {
      return AppString.postCodeMustBeDigits;
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return AppString.postCodeMustContainOnlyDigits;
    } else {
      return null;
    }
  }

  static String? vehicleNumberValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterVehicleNumber;
    } else if (value.length > 17) {
      return AppString.pleaseEnterValidVehicleNumber;
    }
    return null;
  }

  static String? vehicleYearValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseEnterVehicleYear;
    } else if (value.length != 4) {
      return AppString.vehicleYearMustBeDigits;
    }
    return null;
  }

  static String? vehicleMakeValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseSelectVehicleMake;
    }
    return null;
  }

  static String? vehicleModelValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseSelectVehicleModel;
    }
    return null;
  }

  static String? transMissionTypeValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseSelectTransMissionType;
    }
    return null;
  }

  static String? fuelType(String? value) {
    if (value!.isEmpty) {
      return AppString.pleaseSelectFuelType;
    }
    return null;
  }

/* static String? passwordValidator(String? value) {
    log("-->$value");
    if (value!.isEmpty) {
      return AppString.pleaseEnterPassword;
    }  else if (value.length < 6) {
      return AppString.passwordLengthMustBeAtLeastCharacter.tr;
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppString.passwordMustContainUppercase.tr;
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppString.passwordMustContainLowercase.tr;
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return AppString.passwordMustContainNumber.tr;
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return AppString.passwordMustContainSpecialCharacter.tr;
    } else {
      return null;
    }
  }*/

/*  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  */
}

/*extension Validator on String {
  bool isValidEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (isEmpty) {
      showError("Please enter your email address");
      return false;
    } else if (!regex.hasMatch(this)) {
      showError("Email address is invalid");
      return false;
    }
    return true;
  }

  bool isValidPassword() {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    print(length);
    if (isEmpty) {
      showError("Please enter your password");
      return false;
    } else if (length < 6) {
      showError("Password length must be at least 6 character long");
      return false;
    } else if (!regex.hasMatch(this)) {
      showError("Password is invalid");
      return false;
    }
    return true;
  }

  bool isValidMobile() {
    if (isEmpty) {
      showError("Please enter your mobile number");
      return false;
    } else if (!(length > 7 && length < 14)) {
      showError("Invalid mobile number");
      return false;
    }
    return true;
  }
}*/

void showError(String message) {
  AppException(errorCode: 0, message: message).show();
}
