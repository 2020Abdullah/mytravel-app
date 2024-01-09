import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final Function()? SignIn;
  final String myText;
  const MyButton({
    super.key,
    required this.myText,
    required this.SignIn
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: SignIn,
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child:  Text(myText, textAlign: TextAlign.center ,style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,

        ),
    );
  }
}
