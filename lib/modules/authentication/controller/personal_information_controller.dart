import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';

class PersonalInformationController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;

  RxBool isButtonEnabled = false.obs;


  void updateButtonState() {
    isButtonEnabled.value = firstname.text.isNotEmpty&&lastname.text.isNotEmpty&&email.text.isNotEmpty&&postCode.text.isNotEmpty;
  }

  clearData(){
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }



  Future<void> nextBtn() async {
   // Navigation.pushNamed(Routes.addVehicle);
    if (formKey.currentState?.validate() ?? false) {
      Navigation.pushNamed(Routes.addVehicle);
    }

  }
}
