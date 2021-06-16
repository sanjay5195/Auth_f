

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential authCredential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );

  UserCredential authUser = await _auth.signInWithCredential(authCredential);

  final User user = authUser.user;

  assert(user.email !=null);
  assert(user.displayName !=null);
  assert(user.photoURL !=null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

  final User currentUser = await _auth.currentUser;
  assert(user.uid == currentUser.uid);

  return "SignInWithGoogle Succeeded :  $user";
}

void signOutGoogle() async {

  await googleSignIn.signOut();
  print("user sign out");
}