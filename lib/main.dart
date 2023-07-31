import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/Auth/auth_cubit.dart';

import 'package:insta_app/Auth/register_screen.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/responsive/mobile.dart';
import 'package:insta_app/responsive/responsive.dart';
import 'package:insta_app/responsive/web.dart';

import 'package:insta_app/simple_bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final sharedpref = await SharedPreferences.getInstance();
  Constants.userId = sharedpref.getString('userId');

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<LayoutCubit>(
          create: (BuildContext context) => LayoutCubit()
            ..getMyData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:/* /*UserSearchProfileScreen()*/ Constants.userId != null
            ? Responsive(mobScreen: MobileScreen(), webScreen: WebScreen())
            :*/ Registercreen(),
        //  home:  Responsive(mobScreen:MobileScreen() ,webScreen:WebScreen() ),
      ),
    );
  }
}
