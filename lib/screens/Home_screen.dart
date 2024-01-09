import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mytravel/services/auth.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});
  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final Stream<QuerySnapshot?> _categoryStream = FirebaseFirestore.instance.collection("Category").snapshots();
  final user = FirebaseAuth.instance.currentUser;
  bool showProgress = false;
  void selectCategory(context, id, title){
      Navigator.of(context).pushNamed("CategoryInfo", arguments: {
        'title': title,
        'id': id
      });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("دليل سياحي", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: Icon(Icons.home),
      ),
      drawerScrimColor: Colors.black.withOpacity(0.5),
      drawer: Drawer(
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
      body: SafeArea(
        child: StreamBuilder(
          stream: _categoryStream,
          builder: (context, snapshot){
            final categoryList = snapshot.data!.docs;

            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }

            return ModalProgressHUD(
              inAsyncCall: showProgress,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 2,
                    mainAxisExtent: 250
                ),
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: () => selectCategory(context, categoryList![i].id, categoryList![i].get('title')),
                    splashColor: Colors.teal,
                    child: Stack(
                      children: [
                        Image.network(
                          "${categoryList![i].get("image")}",
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("${categoryList![i].get("title")}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white
                          ),),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5)
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


