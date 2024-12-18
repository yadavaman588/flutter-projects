import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/views/auth_screen/login_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

//text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //signin method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: /*e.toString()*/ "Invalid email or password");
    }
    return userCredential;
  }

//signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentuser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentuser!.uid,
      'wishlist_count': '00',
      'order_count': '00',
      'cart_count': '00',
    });
  }

//signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
