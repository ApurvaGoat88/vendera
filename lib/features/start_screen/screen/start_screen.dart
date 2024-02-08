import 'package:flutter/material.dart' ;
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:vendera/common/colors.dart';
import 'package:vendera/common/page_transitions.dart';
import 'package:vendera/features/login/screen/login.dart';
import 'package:vendera/features/signUp/screens/sigp_up_page.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height ;
    return Scaffold(
      body: Container(
        height: h,
        decoration: const  BoxDecoration(

          image: DecorationImage(image: AssetImage('assets/images/bg.jpg'),fit: BoxFit.cover)
        ),
        child: Stack(
          children: [
            Container(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
            end: Alignment.bottomCenter,colors: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),



              ])
            ),


            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,

              child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'philo',
                          fontSize: 40,
                          color: Color(0xFF023020),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Embrace the harmony of nature,\n'
                          ),
                          TextSpan(
                            text: 'we secure a thriving legacy for generations yet to come.',

    style: TextStyle(
    fontSize: 25
    )
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(
                    height: h*0.06,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, createRoute(Login()))  ;
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button ,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ), child: const Text('Login',style: TextStyle(
                    fontSize: 20,
                      fontFamily: 'mont'
                  ),),),
                  SizedBox(
                    height: h*0.02,
                  )
                  ,GlassButton(onPressed: (){
                    Navigator.push(context, createRoute(SignUpPage()))  ;
                  },
                  radius: 10
                    ,blur: 5,

                  border: 2,borderGradient: const LinearGradient(
                    begin: Alignment.bottomLeft,end: Alignment.bottomCenter,colors: [
                    AppColors.button ,
                      AppColors.heading,
                      AppColors.heading,
                    ]), child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    width: 224,
                    child: const Text('Sign up',style: TextStyle(
                        fontSize: 20,
                      fontFamily: 'mont'
                    ),

                    ),
                  ),),
                  SizedBox(
                    height: h*0.02,
                  ),
                  SizedBox(
                    height: h*0.02,
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
