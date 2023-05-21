import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginbloc/auth/login.dart';
import 'package:loginbloc/provider/auth_service.dart';
import 'package:provider/provider.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                                    onPressed: () async {
                                      if (value.formkey.currentState!
                                          .validate()) {
                                        value.createUserWithEmailAndPassword(
                                            context);
                                        Navigator.pop(context);
                                      }
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
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        child: Text(
                          "Sudah Punya akun? Klik disini",
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xffD81110),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        }));
  }
}
