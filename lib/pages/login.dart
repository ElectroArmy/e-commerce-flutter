import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preference;
  bool loading = false;
  bool isLoggedin = false;
  @override
  void initState(){
    super.initState();
    isSignedIn();
          }
         void isSignedIn() async{
           setState(() {
             loading= true;
           });

           preference = await SharedPreferences.getInstance();
           isLoggedin = await googleSignIn.isSignedIn();
          if (isLoggedin) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
          setState(() {
            loading = false;
          });
         }
          Future handleSignIn() async{
            preference = await SharedPreferences.getInstance();

            setState(() {
              loading = true;
            });

            GoogleSignInAccount googleUser = await googleSignIn.signIn();
            GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
            FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
              idToken: googleSignInAuthentication.idToken , 
              accessToken: googleSignInAuthentication.accessToken);

              if (firebaseUser != null) {
                final QuerySnapshot result = await Firestore.instance.collection("user").where("id", isEqualTo: firebaseUser.uid).getDocuments();
                final List<DocumentSnapshot> documents = result.documents;

                if (documents.length == 0) {
                  Firestore.instance
                  .collection("user")
                  .document(firebaseUser.uid)
                  .setData({
                    "id": firebaseUser.uid,
                    "username": firebaseUser.displayName,
                    "profilePicture": firebaseUser.photoUrl,
                    } 
                  );

                  await preference.setString("id", firebaseUser.uid);
                  await preference.setString("username", firebaseUser.displayName);
                  await preference.setString("photoUrl", firebaseUser.displayName);
                }
                else{
                  await preference.setString("id", documents[0]["id"]);
                  await preference.setString("username", documents[0]["username"]);
                  await preference.setString("photoUrl", documents[0]["photoUrl"]);
                }
                Fluttertoast.showToast(msg: "login succesful");
                setState(() {
                  loading = false;
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
              }else{
                  Fluttertoast.showToast(msg: "Login succesful");
              }
            
          }
                      Widget build(BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            centerTitle: true,
                            title: new Text("Login", style: TextStyle(color: Colors.red.shade900)),
                            elevation: 0.2,
                          ),
                          body: Stack(
                            children: <Widget>[
                              Center(child: FlatButton(color: Colors.red.shade900, onPressed: (){handleSignIn();},
                               child: Text("Sign in/ sign up with google", style: TextStyle(color: Colors.white),)),
                               ),
                            Visibility(
                              visible: loading?? true,
                              child:Container(
                                color: Colors.white.withOpacity(0.7),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              ))
                            ],
                          ),
                        );
                      }
            }
            
           