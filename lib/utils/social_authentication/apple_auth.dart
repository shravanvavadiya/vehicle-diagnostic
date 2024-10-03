import 'dart:developer';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../modules/personal_information_view/get_started_screen.dart';
import '../navigation_utils/navigation.dart';

class LoginController extends GetxController {
  RxString appleEmail = ''.obs;
  RxString appleId = ''.obs;
  RxBool appleLoading = false.obs;

  Future<String?> appleLogin() async {
    AuthorizationCredentialAppleID? credential;
    try {
      appleLoading.value = true;
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("credential :: $credential");
      print("credential.email :: ${credential.email}");
      print("credential.givenName :: ${credential.givenName}");
      print("credential.familyName :: ${credential.familyName ?? ''}");
      print("credential.userIdentifier :: ${credential.userIdentifier}");
      print("credential.authorizationCode :: ${credential.authorizationCode}");
      print("credential.identityToken :: ${credential.identityToken}");
      appleEmail.value = credential.email ?? '';
      appleId.value = credential.userIdentifier ?? '';
      Get.offAll(GetStartedScreen());
    } catch (e) {
      log('apple auth error :: $e');
    } finally {
      appleLoading.value = false;
    }
    appleLoading.value = false;
    return credential?.identityToken;
  }
}
