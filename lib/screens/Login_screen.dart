import 'package:flutter/material.dart';
import 'package:mytravel/components/my_Button.dart';
import 'package:mytravel/components/my_TextField.dart';
import 'package:mytravel/services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final _auth = Auth();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late final String _email;
  late final String _password;
  bool _showProgress = false;

  // signin method
  void signIn() async {
    if(_globalKey.currentState!.validate()){
      _globalKey.currentState!.save();
      setState(() {
        _showProgress = true;
      });
      try {
        final authuser = await _auth.LoginUser(_email, _password);
        if(authuser != null){
          Navigator.of(context).pushReplacementNamed('Home');
        }
        setState(() {
          _showProgress = false;
        });
      }
      catch(e) {
        print(e);
      }
    }
  }
  void goToSignUp(){
    Navigator.of(context).pushNamed('SignUp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showProgress,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome.png"),
                fit: BoxFit.cover
              )
            ),
            child: SingleChildScrollView(
              child: Column(
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
                  Form(
                    key: _globalKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text('هل نسيت كلمة السر ؟', style: TextStyle(fontSize: 18),)
                              ],
                            ),
                          ),
                          MyButton(
                              myText: "تسجيل الدخول",
                              SignIn: signIn
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
                                    child: Text("أو يمكنك إنشاء حساب جديد", style: TextStyle(fontSize: 11),),
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
                              onPressed: goToSignUp , child: Text('إنشاء حساب جديد'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
