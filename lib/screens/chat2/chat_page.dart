import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/screens/chat2/ChatUser.dart';
import 'package:o_travel/screens/chat2/conversation_item.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/services/database.dart';
import 'package:o_travel/services/sheard_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Stream<QuerySnapshot> usersStream, chatRoomsStream;
  bool loading = true;
  late String myId, myName, myProfilePic, myUserName, myEmail;

  TextEditingController searchUsernameEditingController =
      TextEditingController();

  getMyInfoFromSharedPreference() async {

    print('SharedPreferenceHelper().getUserId() $myId');
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMyInfoFromSharedPreference();
    SharedPreferenceHelper().getUserId().then((value){
      setState(() {
        myId=value;
      });
      UserType.getType().then((value) {
        getAllChatrooms(!value);
      });
    });
  }

  getAllChatrooms(type) async {
    DatabaseMethods().getUserByTyp(type).then((value) {
      setState(() {
        loading = false;
        usersStream = value;
      });
    });
  }

  Widget searchUsersList() {
    return (loading)
        ? GFLoader()
        : StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        print(ds.data());
                        print("userId ${ds['userID']}\     myId ${myId}");
                        return ConversationItem(
                          myId: myId,
                          user: ChatUser(
                              userId: ds['userID'],
                              imageURL: ds["imgUrl"],
                              name: ds["name"],
                              phone: ds["username"],
                              messageText: '',
                              time: ''),
                          isMessageRead: false,
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'chat')),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [searchUsersList()],
        ),
      ),
    );
  }
}
