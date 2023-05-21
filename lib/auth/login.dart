import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginbloc/auth/register.dart';
import 'package:loginbloc/provider/auth_service.dart';
import 'package:loginbloc/screen/home.dart';
import 'package:provider/provider.dart';
import '../bloc/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AuthService(),
        child: Consumer<AuthService>(builder: (context, value, child) {
          return Scaffold(
              body: Form(
            key: value.formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/splash_logo.png'),
                      SizedBox(height: 20),
                      Text(
                        'Welcome to Mukernas Fornas SOSMA !',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffD81110)),
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: TextFormField(
                        controller: value.emailController,
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return "Email tidak boleh kosong";
                          }
                          if (!validator.contains('@')) {
                            return "Email tidak valid";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color(0xff888888),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Color(0xffE8E8E8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none))),
                      )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          child: TextFormField(
                        controller: value.passwordController,
                        obscureText: true,
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Color(0xff888888),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Color(0xffE8E8E8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none))),
                      )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (constext) =>
                                                  RegisterView()));
                                    },
                                    child: Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffF0AF7F)),
                                  ))),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (value.formkey.currentState!.validate()) {
                                    value.signInWithEmailAndPassword(context);
                                  }
                                },
                                child: Icon(Icons.arrow_forward_ios_rounded),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffD81110),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xffD81110),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              final user = await value.signInWithGoogle();
                              if (user != null) {
                                print('Berhasil Login');
                              } else
                                (e) {
                                  print(e);
                                };
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.g_mobiledata,
                                    color: Color(0xffD81110)),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "Sign In With Google",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffD81110)),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: BorderSide(
                                    color: Color(0xffD81110), width: 2)),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ));
        }));
  }
}
