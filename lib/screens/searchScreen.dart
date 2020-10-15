import 'package:flutter/material.dart';
import 'package:jn_chat_app/Widgets/widgets.dart';
import 'package:jn_chat_app/helper/constants.dart';
import 'package:jn_chat_app/helper/helperFunction.dart';
import 'package:jn_chat_app/screens/conversation.dart';
import 'package:jn_chat_app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController search = new TextEditingController();
  QuerySnapshot searchSnapshot;

  var searchresult = new Map();
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                username: searchSnapshot.docs[index].data()["name"],
                useremail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  initiateSearch() {
    databaseMethods.getUsersByUsername(search.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatroom({String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    }
  }

  Widget searchTile({String username, String useremail}) {
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(
                useremail,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroom(userName: username);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    _myName = await HelperFunctions.getUserNamesharedPreference();
    setState(() {});
    print("$_myName");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: search,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Piazzolla',
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixStyle: TextStyle(),
                        border: InputBorder.none,
                        hintText: "Search Friend.....",
                        hintStyle: TextStyle(color: Colors.white54)),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36ffffff),
                                const Color(0x0fffffff)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/search_white.png")),
                    ),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}
