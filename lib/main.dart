
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendera/bloc/connectivity/internet_bloc.dart';
import 'package:vendera/features/connection_check/connectivity_check.dart';
import 'package:vendera/features/start_screen/screen/start_screen.dart';

void main(){
  runApp(const MyApp()) ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InternetBloc())
      ],

      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF98FB98) ,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'mont'
            )
          )
        ),
        debugShowCheckedModeBanner: false,
        home: const InternetCheck(),
      ),
    );
  }
}
