
import 'package:boost_provider_state/provider/home_screen_provider.dart';
import 'package:boost_provider_state/provider/login_provider.dart';
import 'package:boost_provider_state/provider/registration_provider.dart';
import 'package:boost_provider_state/provider/select_property_provider.dart';
import 'package:boost_provider_state/provider/service_owner_provider.dart';
import 'package:boost_provider_state/ui/category/all_category.dart';
import 'package:boost_provider_state/ui/home_page.dart';
import 'package:boost_provider_state/ui/notification/notification_screen.dart';
import 'package:boost_provider_state/ui/property/property_create.dart';
import 'package:boost_provider_state/ui/property/property_list.dart';
import 'package:boost_provider_state/ui/property/property_search.dart';
import 'package:boost_provider_state/ui/property/select_property.dart';
import 'package:boost_provider_state/ui/service/service_owner.dart';
import 'package:boost_provider_state/ui/splash/splash_screen.dart';
import 'package:boost_provider_state/ui/splash/welcome_screen.dart';
import 'package:boost_provider_state/ui/user_auth/account_settings.dart';
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
        ChangeNotifierProvider(create: (_)=> RegistrationProvider()),
        ChangeNotifierProvider(create: (_)=> SelectPropertyProvider()),
        ChangeNotifierProvider(create: (_)=> HomeScreenProvider()),
        ChangeNotifierProvider(create: (_)=> ServiceOwnerProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        builder: EasyLoading.init(),
        routes: {
          '/welcome':(context)=> WelcomeScreen(),
          '/login':(context)=> Login(),
          '/registration':(context)=> RegistrationScreen(),
          '/selectProperty':(context)=> SelectPropertyScreen(),
          '/homePage':(context)=> HomePage(),
          '/propertyCreate':(context)=> PropertyCreate(),
          '/propertyList':(context)=> PropertyList(),
          '/propertySearch':(context)=> PropertySearch(),
          '/serviceOwner':(context)=> ServiceOwner(),
          '/notification':(context)=> NotificationScreen(),
          '/accountSettings':(context)=> AccountSettings(),
          '/allCategory':(context)=> AllCategory(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => SplashScreen();
}



