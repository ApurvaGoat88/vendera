import 'package:connectivity/connectivity.dart';
import'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendera/bloc/connectivity/internet_bloc.dart';
import 'package:vendera/common/colors.dart';
import 'package:vendera/features/start_screen/screen/start_screen.dart';

class InternetCheck extends StatelessWidget {
  const InternetCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc ,InternetState>(builder: (context , state){
      if (state is InternetGainState){
        return const StartScreen() ;
      }
      else{
        return Scaffold(
          backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tree.jpg'),
                  const Text('No Internet ',style: TextStyle(
                    fontFamily: 'philo',
                    fontSize: 30,
                    color: AppColors.heading
                  ),),
                  const SizedBox(height: 30,),
                  ElevatedButton(onPressed: ()async {
                    final conn = Connectivity();
                    await conn.checkConnectivity() ;
                  },style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.heading,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ), child: const Text('Reload',style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'mont'
                  ),),),
                ],
              ),
            ),
        );
      }

    }) ;
  }
}
