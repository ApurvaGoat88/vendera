import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vendera/common/colors.dart';
import 'package:vendera/features/home_page/screen/home_page.dart';
import 'package:vendera/features/start_screen/screen/start_screen.dart';
class AuthCheck  extends StatelessWidget {
  const AuthCheck ({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
      if (snapshot.connectionState== ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.heading,
          ),
        );
      }
      else{
        if (snapshot.hasData){
          return const HomePage() ;
        }
        else{
          return const StartScreen() ;
        }
      }
    });
  }
}
