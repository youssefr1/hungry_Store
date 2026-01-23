import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry_store/features/auth/views/login_view.dart';
import 'package:hungry_store/features/auth/views/signup_view.dart';
import 'package:hungry_store/root.dart';
import 'package:hungry_store/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        title: 'Hungry App',
        home: Root(),
      ),
    );
  }
}

