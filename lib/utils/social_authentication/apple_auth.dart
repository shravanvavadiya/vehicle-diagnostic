
import 'dart:developer';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../modules/personal_information_view/get_started_screen.dart';
import '../navigation_utils/navigation.dart';


class AppleSignInAuth extends GetxController{
  RxString appleEmail = ''.obs;
  RxString appleId = ''.obs;
  RxBool appleLoading= false.obs;

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
     Navigation.push(const GetStartedScreen());
    } catch (e) {
      log('apple auth error :: $e');
    } finally {
      appleLoading.value = false;
    }
    appleLoading.value = false;
    return credential?.identityToken;
  }

 /* Future<void> appleAuthentication(String token, String email, String appleId) async {
    try {
      appleLoading.value = true;
      var result = await AuthService.appleSignInService(email, token, appleId);
      LogUtils.debugLog('appleAuthentication result ::$result');
      await AppPreference.setUserToken(result.apiResponse?.data?.token ?? '');
      await AppPreference.setString('profile_image_link', result.apiResponse?.data?.profileUrl ?? "");
      await AppPreference.setString('user_name', result.apiResponse?.data?.name ?? "");
      await AppPreference.setUserRegister(result.apiResponse?.data?.verified ?? false);
      OtpVerificationModel otpVerificationModel = OtpVerificationModel(
        navigationType: NavigationType.loginWithEmail,
      );
      await AppPreference.setModelData(result);
      await AppPreference.setUserMantra(result.apiResponse?.data?.personalMantra ?? '');
      await AppPreference.setUserName(result.apiResponse?.data?.name ?? '');
      await AppPreference.setCurrentOccupation(result.apiResponse?.data?.currentOccupation ?? '');
      await AppPreference.firebaseUserData(result.apiResponse?.data ?? RegisterData());
      await AppPreference.setLoginUserId(result.apiResponse?.data?.id ?? '');

      String menuItem = "";
      if (result.apiResponse?.data?.backgroundColor == AppTheme.pinkColor.value) {
        menuItem = AppString.pretty;
      } else if (result.apiResponse?.data?.backgroundColor == AppTheme.blueColor.value) {
        menuItem = AppString.blueCollared;
      } else if (result.apiResponse?.data?.backgroundColor == AppTheme.redColor.value) {
        menuItem = AppString.redCollared;
      } else if (result.apiResponse?.data?.backgroundColor == AppTheme.yellowColor.value) {
        menuItem = AppString.lamborghiniYellow;
      } else if (result.apiResponse?.data?.backgroundColor == AppTheme.greyColor.value) {
        menuItem = AppString.electricGray;
      } else {
        menuItem = AppString.executive;
      }
      AppColors.themeColor(themeName: menuItem);

      if (result.apiResponse?.data?.verified ?? false) {
        AppPreference.setVisionGuideDialogToFalse();
        AppPreference.setSettingsGuideDialogToFalse();
        final getUserData = await FirebaseService.userPath(userID: result.apiResponse?.data?.id ?? '').get();
        LogUtils.debugLog('getUserData :: LOGIN WITH APPLE :: ${getUserData.data()}');
        var appleModel = result.apiResponse?.data;
        appleModel?.fcmToken = Constants.firebaseToken;
        appleModel?.friendsList = <String>[...getUserData.data()?['friendsList'] ?? []];
        FirebaseService.userPath(userID: result.apiResponse?.data?.id ?? '')
            .set(
          appleModel?.toJson() ?? {},
          SetOptions(merge: true),
        )
            .then((value) => LogUtils.successLog('FirebaseService  appleAuth ====>success::'))
            .onError((error, stackTrace) => LogUtils.errorLog('FirebaseService  appleAuth ====>error :: $error'));

        if (AppPreference.getOnBoarding()) {
          AppPreference.setOnBoarding(value: true);
          Navigation.replaceAll(Routes.homeScreen);
        } else {
          AppPreference.setHome(value: true);
          Navigation.replaceAll(Routes.onBoarding);
        }
      } else {
        Navigation.pushNamed(Routes.userProfileScreen, arg: otpVerificationModel);
      }
      appleLoading.value = false;
    } catch (e, st) {
      LogUtils.debugLog('apple login API error :: $e :: st :: $st');
    } finally {
      appleLoading.value = false;
    }
  }*/
}

