import 'dart:developer';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuth {
  //static FirebaseAuth auth = FirebaseAuth.instance;
  static List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
 static  Future<String?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser;
    GoogleSignInAuthentication? googleAuth;
    try {
      await GoogleSignIn().signOut();
      googleUser = await GoogleSignIn(
        clientId:
        '984326484531-if526hqnml5hdvvb1paovglkbihfqenb.apps.googleusercontent.com',
        scopes: scopes,
      ).signIn();
      googleAuth = await googleUser?.authentication;
      log("Google Token====>idToken::${googleAuth?.idToken}");
      // if (googleUser != null && (googleAuth?.idToken?.isNotEmpty ?? false)) {
      // } else {
      //   log("Something went Wrong");
      // }
      // await GoogleSignIn().signOut();
      // Navigation.push(const GetStartedScreen());
      return googleUser?.email;
    } on Exception catch (e, st) {
      log("Google Token====>error::$e");

      AppSnackBar.showErrorSnackBar(message: "Something went Wrong", title: 'error');
      rethrow;
    }
  }

 /* static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ...
      }
    }

    return user;
  }

  static Future<void> signOutGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await auth.signOut();
    } catch (e) {
      //...
    }
  }*/
}
