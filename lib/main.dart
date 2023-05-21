import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginbloc/auth/login.dart';
import 'package:loginbloc/auth/register.dart';
import 'package:loginbloc/provider/auth_service.dart';

import 'package:loginbloc/screen/home.dart';
import 'package:loginbloc/screen/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => WrapperView(),
          '/login': (context) => LoginView(),
          '/register': (context) => RegisterView(),
        },
      ),
    );
  }
}
