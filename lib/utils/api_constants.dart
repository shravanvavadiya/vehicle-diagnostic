class ApiConstants {
  static const String baseUrl = "http://103.206.139.86:8070/";
  static const String signUp = "auth/googleTokenVerify";
  static const String googleTokenVerify = "auth/googleTokenVerify";
  static const String appleTokenVerify = "auth/appletokenVerify";
  static const String accountCreate = "auth/register";
  static const String accountLogin = "auth/login";
  static const String accountOtpVerify = "auth/user-verify";
  static const String forgotPasswordVerify = "auth/password-otp-verify";
  static const String resendOtp = "auth/forgotpassword";
  static const String resetPassword = "auth/reset-password";
  static const String user = "user/";
  static const String updateUser = "user/update";
  static const String getAllVehicle = "vehicle/all";
  static const String getAllVehicleByUserId = "vehicle/user";
  static const String addVehicle = "vehicle/";
  static const String getVehicleQue = "questionanswer/all";
  static const String submitVehicleRequest = "moreaboutvehicle/";
  static const String editVehicleRequest = "moreaboutvehicle/updateAboutVehicle";
  static const String deleteVehicle = "vehicle/delete/";
  static const String deleteUserAccount = "user/delete/";
}

class ApiKeyConstants {
  static const String deviceType = "deviceType";
  static const String token = "token";
  static const String appleId = "appleid";
  static const String appleToken = "appletoken";
  static const String email = "email";
}
