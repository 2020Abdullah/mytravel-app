import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CategoryTrip_screen extends StatefulWidget {
  const CategoryTrip_screen({Key? key}) : super(key: key);
  @override
  State<CategoryTrip_screen> createState() => _CategoryTrip_screenState();
}
class _CategoryTrip_screenState extends State<CategoryTrip_screen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    void logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed("/");
    }

    final routeArgument = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final categoryId = routeArgument['id'];
    final categoryName = routeArgument['title'];

    final Stream<QuerySnapshot> _categoryInfoStream = FirebaseFirestore.instance.collection("CategoryInfo")
        .where("category_id", isEqualTo: categoryId).snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryName!),
        backgroundColor: Colors.green,
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
          stream: _categoryInfoStream,
          builder: (context, snapshot){
            final categoryInfo = snapshot.data!.docs;
            if(snapshot.hasError){
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: categoryInfo.length,
                  itemBuilder: (context, i){
                    return Card(
                      child: Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)
                                  ),
                                  child: Image.network("${categoryInfo![i].get("imageUrl")}",
                                    height: 250,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 20
                                  ),
                                  alignment: Alignment.bottomRight,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0),
                                            Colors.black.withOpacity(0.8)
                                          ],
                                          stops: [0.5 , 1]
                                      )
                                  ),
                                  child: Text("${categoryInfo![i].get("title")}", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade
                                  ),),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.flag_circle,
                                        color: Colors.amberAccent,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${categoryInfo![i].get("country")}", style: TextStyle(
                                        fontSize: 16
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wb_sunny,
                                        color: Colors.amberAccent,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${categoryInfo![i].get("Season")}", style: TextStyle(
                                          fontSize: 16
                                      ),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      )
    );
  }
}
