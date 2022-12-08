import 'package:boost_provider_state/provider/login_provider.dart';
import 'package:boost_provider_state/provider/registration_provider.dart';
import 'package:boost_provider_state/ui/home_page.dart';
import 'package:boost_provider_state/ui/user_auth/log_in.dart';
import 'package:boost_provider_state/ui/user_auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> LoginProvider()),
        ChangeNotifierProvider(create: (_)=> RegistrationProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login(),
        builder: EasyLoading.init(),
        routes: {
          '/login':(context)=> Login(),
          '/registration':(context)=> RegistrationScreen(),
          '/homePage':(context)=> HomePage()
        },
      ),
    );
  }
}

