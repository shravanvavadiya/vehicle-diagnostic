import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';

import '../../../utils/app_string.dart';

class SignInController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString buttonName = AppString.createAccount.obs;
}
