import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registerlogin/Screen/login_screen.dart';
import 'package:registerlogin/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final FlashCardButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.blue,
    child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {},
        child: Text(
          "FlashCards",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        )),
  );

  final quizButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.blue,
    child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {},
        child: Text(
          "Quiz",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        )),
  );

  final LeaderboardButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.blue,
    child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {},
        child: Text(
          "Leaderboard",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        )),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          Text(
            "Welcome ${loggedInUser.username}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          SizedBox(
            width: 80,
          ),
          ActionChip(
              label: Text(
                "Logout",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                logout(context);
              })
        ],
      )),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              SizedBox(height: 5),
              FlashCardButton,
              SizedBox(height: 20),
              quizButton,
              SizedBox(height: 20),
              LeaderboardButton,
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
