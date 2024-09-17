import 'dart:developer';

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
      log("idToken:: --->${idToken}");
      print("idToken::$idToken");
      if (idToken?.isEmpty ?? true) {
        throw Exception('IDToken not found');
      }
      return idToken!;
    } on Exception catch (e, st) {
      rethrow;
    }
  }

  static Future<String> signInWithApple() async {
    AuthorizationCredentialAppleID? credential;
    List<AppleIDAuthorizationScopes> scopes =[
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ];
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: scopes
      );
      print("identityToken ===> ${credential.identityToken}");
      String? identityToken = credential.identityToken;
      if (identityToken?.isEmpty ?? true) {
        throw Exception('IdentityToken not found');
      }
      print("identityToken ===> $identityToken");
      return identityToken!;
    }
    on Exception catch (e,st){
      rethrow;
    }
  }
}
