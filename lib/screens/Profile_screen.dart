import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytravel/components/my_Button.dart';
import 'package:mytravel/components/my_TextField.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({Key? key}) : super(key: key);
  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late String _email;
  late String _name;
  late String _password;

   updateProfile() async {
      if(!nameController.text.isEmpty){
        await user?.updateDisplayName(nameController.text);
      }
      if(!emailController.text.isEmpty){
        await user?.updateEmail(emailController.text);
      }
      if(!passwordController.text.isEmpty){
        await user?.updatePassword(passwordController.text);
      }
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: "عملية ناجحة !",
          desc: "تم تحديث بياناتك بنجاح",
          showCloseIcon: true,
          btnOkIcon: Icons.check_circle,
          btnOkOnPress: () {},
          btnOkText: "حسناً"
      )..show();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحتك الشخصية", style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: Icon(Icons.home),
      ),
      drawerScrimColor: Colors.black.withOpacity(0.5),
      drawer:  Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Image.asset("assets/images/profile.png"),
                ),
                accountName: Text("${user?.displayName}"),
                accountEmail: Text("${user?.email}")
            ),
            ListTile(
              title: Text("الرئيسية"),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.of(context).pushNamed("Home");
              },
            ),
            ListTile(
              title: Text("التصنيفات"),
              leading: Icon(Icons.category),
              onTap: (){
                Navigator.of(context).pushNamed("Home");
              },
            ),
            ListTile(
              title: Text("الإعدادات"),
              leading: Icon(Icons.settings),
              onTap: (){
                Navigator.of(context).pushNamed("profile");
              },
            ),
            ListTile(
              title: Text("تسجيل الخروج"),
              leading: Icon(Icons.logout_rounded),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/images/profile.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("تعديل الملف الشخصي", style: TextStyle(
                  fontSize: 20
                ),),
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    MyTextField(
                        controller: nameController,
                        hintText: "اسمك",
                        obscureText: false,
                        onclicked: (value){
                          _name = value!;
                        },
                    ),
                    SizedBox(height: 10,),
                    MyTextField(
                      controller: emailController,
                      hintText: "البريد الإلكتروني",
                      obscureText: false,
                      onclicked: (value){
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 10,),
                    MyTextField(
                      controller: passwordController,
                      hintText: "كلمة مرور جديدة",
                      obscureText: true,
                      onclicked: (value){
                        _password = value!;
                      },
                    ),
                    SizedBox(height: 10,),
                    MyButton(
                        myText: "تحديث البيانات",
                        SignIn: updateProfile
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
