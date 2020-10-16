import 'package:cfi_complaints/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cfi_complaints/models/cfi_user.dart';

// This is a class and plays a key role in signing in,
// registering and signing out tasks.
// Note: IMP: 1) FirebaseUser changed to User
//            2) AuthResult changed to UserCredential

class AuthService {
  // This is the key for all the data thats being stored in firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This method creates user object based on firebaseUser
  // It obtains the uid of the user from firebase (using
  // inbuilt 'FirebaseUser' class) and returns it.

  CfiUser userFromFirebaseUser(FirebaseUser user) {
    return user != null ? CfiUser(uid: user.uid) : null;
  }

  // auth change user stream
  // This is like a bridge between firebase and us
  // Gives us the details of the user from the firebase

  // we ll call it user
  Stream<CfiUser> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => userFromFirebaseUser(user));
        .map(userFromFirebaseUser);
  }

  // Things to do in this file -
  // 1) Sign in anonymously
  Future signInAnon() async {
    try {
      // It is going to sign in anonymously and returns result
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // 2) Sign in with email and password
  // Returns the uid of the user.
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user); // returns 'uid' of user
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // 3) Register with email and password

  Future registerWithEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print("My uid from auth = " + user.uid);
      // create a new document for the user with the uid - in firestore database
      // Update this ------------------
      await DatabaseService(uid: user.uid).updateUserData(user.uid);

      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // 4) Sign out

  Future signOut() async {
    // This signout is our method
    try {
      return await _auth.signOut(); //This signOut is built-in firebase method
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
