import 'package:flutter_template/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginService {
  static Future<String> signInWithGoogle() async {
    List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];
    try {
      await GoogleSignIn().signOut();
      GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: Constants.clientId,
        // scopes: scopes,
      ).signIn();
      String? idToken = (await googleUser?.authentication)?.idToken;
      print("idTOken::$idToken");
      if (idToken?.isEmpty ?? true) {
        throw Exception('IDToken not found');
      }
      return idToken!;
    } on Exception catch (e, st) {
      rethrow;
    }
  }
  static Future<String> appleLogin() async {
    AuthorizationCredentialAppleID? credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.identityToken?.isEmpty ?? true) {
        throw Exception('identityToken not found');
      }
    } catch (e) {
      rethrow;
    }
    return credential.identityToken!;
  }
}
