

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);

  Future<UserCredential?> registerUser(String email, String password) async{
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return user;
    }catch(e){
      return null;
    }
  }

  Future<UserCredential?> signInUser(String email, String password) async{
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return user;
    }catch(e){
      return null;
    }
  }

  Future logOutUser() async{
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
    }catch(e){
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogleAccount() async{
    try{
      GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

      GoogleSignInAuthentication authentication = await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken
      );

      if(await _checkEmail(googleUser.email)){
        return _auth.signInWithCredential(credentials);
      }

      return null;
    }catch(e){
      return null;
    }
  }

  Stream<User?> authState(){
    return _auth.authStateChanges();
  }

  Future<bool> _checkEmail(String email) async{

    late bool isThere;

    await _auth.fetchSignInMethodsForEmail(email).then((listOfMethods){
      if(listOfMethods.isEmpty){
        isThere = false;
      }else{
        isThere = true;
      }
    });

    return isThere;
  }
}