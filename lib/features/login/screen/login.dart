import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vendera/bloc/authentication/sigin/sign_in_bloc.dart';
import 'package:vendera/common/colors.dart';
import 'package:vendera/common/page_transitions.dart';
import 'package:vendera/features/home_page/screen/home_page.dart';
import 'package:vendera/features/signUp/screens/sigp_up_page.dart';
import 'package:vendera/models/user_model.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // User canceled the Google Sign In process
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid.toString()).get();
      if (!doc.exists){
        final usermodel = UserModel(username: user.displayName.toString(), email: user.email.toString(), uid: user.uid.toString());
        await FirebaseFirestore.instance.collection('users').doc(user.uid.toString()).set(usermodel.toJson()) ;
      }
      return user;
    } catch (error) {
      return null;
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obsure =false ;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height ;
    final w = MediaQuery.sizeOf(context).width ;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/login_bg.jpg'),fit: BoxFit.cover)
          ),
          child: Container(
            height: h*0.7,
            width: w,
            decoration:  BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.89),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(100) ,topLeft: Radius.circular(25))
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child:  SizedBox(
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
                                      text: 'Step into your personalized space,\n'
                                  ),
                                  TextSpan(
                                      text: 'Log in and embark on your journey with us.',
        
                                      style: TextStyle(
                                          fontSize: 25
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                    ),
                    SizedBox(
                      height: h*0.04,
                    ),
                    TextFormField(
                      controller: _emailController,
                      
                      keyboardType: TextInputType.emailAddress,
                      
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: const Icon(Icons.email,color: AppColors.heading,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.heading,
                                width: 2
        
        
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.heading,
                                width: 2
        
        
                            )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.heading,
                            width: 2
        
        
                          )
                        ),
        
                      ),
                      onChanged: (value){
                        BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));

                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_obsure,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Password',
        
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
        
                            _obsure = !_obsure ;
                          });
                        }, icon: Icon(Icons.remove_red_eye_rounded ,color: !_obsure ? AppColors.heading : AppColors.button,)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.heading,
                                width: 2
        
        
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.heading,
                                width: 2
        
        
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.heading,
                                width: 2
        
        
                            )
                        ),
        
                      ),
                      onChanged: (value){
                        BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));
                      },
                    ),
                    const SizedBox(height:16),
                    BlocBuilder<SignInBloc,SignInState>(builder: (context, state){
                      if (state is SignInErrorState){
                        return Text(state.error,style: const TextStyle(
                            fontFamily: 'mont',

                            color: Colors.red
                        ),);
                      }
                      else if (state is SignInValidState){
                        return const Text('You are all set to Go! ',style: TextStyle(
                            fontFamily: 'mont',

                            color: Colors.green
                        ),);
                      }
                      else{
                        return Container( );
                      }
                    }),
                    const SizedBox(height: 16),
                    BlocBuilder<SignInBloc,SignInState>(
                      builder: (context,state) {
                        return ElevatedButton(onPressed: ()async {
                          if(state is SignInValidState){
                            showDialog(barrierDismissible: false,context: context, builder: (context){
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.heading,
                                ),
                              );
                            });
                            final userCreds = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                            final user = userCreds.user ;
                            Navigator.pop(context) ;
                            if (user!=null){
                              Navigator.pushAndRemoveUntil(
                                context,
                                createRoute(const HomePage()),
                                    (route) => false,
                              );                            }
                           
                          }
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
                        ),),);
                      }
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color:AppColors.heading
                            ,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or',style: TextStyle(
                              fontFamily: 'exo',
                              color: AppColors.heading
                          ),),
                        ),
                        Expanded(
                          child: Divider(
                              color: AppColors.heading
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GlassButton(onPressed: ()async {
                      final user = await signInWithGoogle() ;
                      if (user!=null){
                        Navigator.pushAndRemoveUntil(
                          context,
                          createRoute(const HomePage()),
                              (route) => false,
                        );                        }
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Google',style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'mont'
                            ),

                            ),
                          ],
                        ),
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 5), // Adjust spacing if needed
                        GestureDetector(
                          onTap: () {
                            // Navigate to SignUp page or perform SignUp action
                            Navigator.push(context, createRoute(SignUpPage()));
                          },
                          child: const Text(
                            'Create now ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
      ),

    );
  }
}
