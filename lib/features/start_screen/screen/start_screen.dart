import 'package:flutter/material.dart' ;
import 'package:vendera/common/colors.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height ;
    final w = MediaQuery.sizeOf(context).width ;
    const color = AppColors.heading ;
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
                  ElevatedButton(onPressed: (){}, child: const Text('Login',style: TextStyle(
                    fontSize: 20,
                      fontFamily: 'mont'
                  ),),style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button ,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),),
                  SizedBox(
                    height: h*0.02,
                  )
                  ,OutlinedButton(onPressed: (){}, child: const Text('Sign up',style: TextStyle(
                      fontSize: 20,
                    fontFamily: 'mont'
                  ),
                  ),style:OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Color(0xFF023020)
                    ),

                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(10)
                    )
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
