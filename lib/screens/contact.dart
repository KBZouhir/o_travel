import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact"),
        ),
        body:SingleChildScrollView(
          child:  Container(
            height: 800,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/Contact.png',
                  ),
                ),
                SizedBox(
                    height: 16
                ),
                Text(
                  'Eamil',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color:Theme.of(context).accentColor),
                ),
                SizedBox(
                    height: 8
                ),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Example@gmail.com',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(raduice))),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                    height: 16
                ),
                Text(
                  'Subject',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                    height: 8
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {

                    });
                  },
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(raduice))),
                  ),
                  style: TextStyle(
                    height: 1.6,
                    fontSize: 16,
                    decorationThickness: 0,
                  ), // when user presses enter it will adapt to it
                ),
                SizedBox(
                    height: 16
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(raduice),
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) );
  }
}
