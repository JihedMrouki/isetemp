import 'package:flutter/material.dart';
import 'package:iset_emploi/screens/admin/admin_home.dart';
import 'package:iset_emploi/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


// ignore: camel_case_types
class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<loginScreen> {
// forms
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
// fire base

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("please enter your email");
          }
          if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9+_,-]+.[a-z]")
              .hasMatch(value)) {
            return ("please enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'EMAIL',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    //password
    final passwordlField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.vpn_key),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'PASSWORD',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    //ButtonLogin
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            login(emailController.text, passwordController.text);
          },
          child: const Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 25),
                          emailField,
                          const SizedBox(height: 25),
                          passwordlField,
                          const SizedBox(height: 35),
                          loginButton,
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Dont't have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: const Text("SignUp",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                              )
                            ],
                          )
                        ])),
              ),
            ),
          ),
        ));
  }

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AdminPage())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
