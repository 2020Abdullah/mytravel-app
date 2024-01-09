import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytravel/components/my_Button.dart';
import 'package:mytravel/components/my_TextField.dart';
import 'package:mytravel/services/FirestoreDB.dart';
import 'package:mytravel/services/auth.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});
  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  final __auth = Auth();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late final String _email;
  late final String _password;
  late final String _username;

  // signin method
  void SignUp() async {
    if(_globalKey.currentState!.validate()){
      _globalKey.currentState!.save();
      try {
        final authResult = await __auth.createUser(_email, _password);
        if(authResult != null){
          final user = FirebaseAuth.instance.currentUser;
          await user?.updateDisplayName(_username);
          Navigator.of(context).pushReplacementNamed('Home');
        }
      }
      catch(e){
        print(e);
      }

    }
  }
  void goToLogin(){
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/welcome.png"),
              fit: BoxFit.cover
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                SizedBox(height: 100),
                Icon(
                  Icons.add_location,
                  size: 100,
                ),
                SizedBox(height: 20),
                // welcome
                Text("مرحباً بك في دليلي للسياحة", style: TextStyle(
                    fontSize: 30
                ),),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: emailController,
                          hintText: 'اسم المستخدم',
                          obscureText: false,
                          onclicked: (value){
                            _username = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        MyTextField(
                          controller: usernameController,
                          hintText: 'البريد الإلكتروني',
                          obscureText: false,
                          onclicked: (value){
                            _email = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'كلمة المرور',
                          obscureText: true,
                          onclicked: (value){
                            _password = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        MyButton(
                            myText: "إنشاء الحساب",
                            SignIn: SignUp
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 1),
                                  child: Text("أو يمكنك تسجيل الدخول ", style: TextStyle(fontSize: 11),),
                                )
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                            onPressed: goToLogin , child: Text('تسجيل الدخول'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
