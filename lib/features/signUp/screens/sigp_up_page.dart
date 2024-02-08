import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vendera/bloc/authentication/sigin/sign_in_bloc.dart';
import 'package:vendera/bloc/authentication/sign_up/sign_up_bloc.dart';
import 'package:vendera/common/colors.dart';
import 'package:vendera/common/page_transitions.dart';
import 'package:vendera/features/home_page/screen/home_page.dart';
import 'package:vendera/features/login/screen/login.dart';
import 'package:vendera/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      print("Error during Google Sign-In: $error");
      return null;
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _obsure =false ;
  bool _obsure2 =false ;
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
              image: DecorationImage(image: AssetImage('assets/images/signUp.jpg'),fit: BoxFit.cover)
          ),
          child: Container(
            height: h*0.77,
            width: w,
            decoration:  BoxDecoration(
                color: Colors.grey.shade100.withOpacity(0.89),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(25) ,topLeft: Radius.circular(80))
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'philo',
                                  fontSize: 20,
                                  color: Color(0xFF023020),
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Sign Up for a Greener Tomorrow!\n'
                                          ,style: TextStyle(
                                    fontSize: 28
                                  )
                                  ),

                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: h*0.01,
                    ),
                    TextFormField(
                      controller: _usernameController,

                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        labelText: 'Username',
                        suffixIcon: const Icon(Icons.person,color: AppColors.heading,),
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
                        // BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));
                          BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangedEvent(_emailController.text, _passwordController.text, _cpasswordController.text,_usernameController.text));
                      },
                    ),
                    const SizedBox(height: 16),
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
                        // BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));
                        BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangedEvent(_emailController.text, _passwordController.text, _cpasswordController.text,_usernameController.text));

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
                        BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangedEvent(_emailController.text, _passwordController.text, _cpasswordController.text,_usernameController.text));

                        // BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));
                      },
                    ),
                    const SizedBox(height:16),
                    TextFormField(
                      controller: _cpasswordController,
                      obscureText: !_obsure2,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',

                        suffixIcon: IconButton(onPressed: (){
                          setState(() {

                            _obsure2 = !_obsure2 ;
                          });
                        }, icon: Icon(Icons.remove_red_eye_rounded ,color: !_obsure2 ? AppColors.heading : AppColors.button,)),
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
                        BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangedEvent(_emailController.text, _passwordController.text, _cpasswordController.text,_usernameController.text));

                        // BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(_emailController.text, _passwordController.text));
                      },
                    ),
                    const SizedBox(height:16),
                    BlocBuilder<SignUpBloc,SignUpState>(builder: (context, state){
                      if (state is SignUpErrorState){
                        return Text(state.error,style: const TextStyle(
                            fontFamily: 'mont',
                            fontSize: 10,
                            color: Colors.red
                        ),);
                      }
                      else if (state is SignUpValidState){
                        return const Text('You are all set to Go! ',style: TextStyle(
                            fontFamily: 'mont',
                            fontSize: 10,
                            color: Colors.green
                        ),);
                      }
                      else{
                        return Container();
                      }
                    }),
                    const SizedBox(height: 16),
                    BlocBuilder<SignUpBloc,SignUpState>(
                      builder: (context,state) {
                        return ElevatedButton(onPressed: ()async {
                          
                          print(state) ;
                            if(state is SignUpValidState) {
                              print('auth');
                              showDialog(barrierDismissible: false,context: context, builder: (context){
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.heading,
                                  ),
                                );
                              });
                              try {
                                FirebaseAuth _auth = FirebaseAuth.instance;
                                final userCredentials = await _auth
                                    .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                final usermodel = UserModel(
                                    username: _usernameController.text,
                                    email: _emailController.text,
                                    uid: userCredentials.user!.uid.toString());
                                await FirebaseFirestore.instance.collection(
                                    'users').doc(usermodel.uid).set(
                                    usermodel.toJson());
                                final user = userCredentials.user;
                                Navigator.pop(context);
                                if(user != null){
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    createRoute(const HomePage()),
                                        (route) => false,
                                  );                                  }
                              }
                              catch (e){
                                print(e.toString()) ;
                              }

                            }

                            else{
                              print("not signUp State");
                            }
                        },style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button ,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ), child: const Text('Create Account',style: TextStyle(
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5), // Adjust spacing if needed
                        GestureDetector(
                          onTap: ()  {
                            Navigator.pushReplacement(context,createRoute(Login()) ) ;

                          },
                          child: Text(
                            'SignIn now',
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
