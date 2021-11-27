import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/auth/reset/reset.dart';
import 'package:o_travel/screens/localization/const.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Column(
          children: [
            Container(
              height: size.height / 2.5,
              width: size.width,
              color: Theme.of(context).primaryColor,
            ),
            Container(
              height: size.height - (size.height / 2.5),
              width: size.width,
              color: Theme.of(context).backgroundColor,
            )
          ],
        ),
        Positioned(
            top: size.height * 0.07,
            right: 0,
            left: 0,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 40,
                            )),                          Spacer(),

                      ],
                    ),

                    Text(
                      getTranslated(context, 'forgot_password'),
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getTranslated(context, 'confirm_code_text'),
                      style: TextStyle(
                          fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                      width: size.width * 0.9,
                      height: 250,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 15,
                              color: Colors.grey.withOpacity(0.4),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            getTranslated(context, 'code'),
                            style: TextStyle(
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConfirmationCodeWidget()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      getTranslated(context, 'didnt_receive_code'),
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          getTranslated(context, 'resend_code'),
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(raduice),
                      ),
                      child: MaterialButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPage())),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          getTranslated(context, 'done'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )))
      ],
    )));
  }
}
class ConfirmationCodeWidget extends StatefulWidget {
  @override
  _ConfirmationCodeWidgetState createState() => _ConfirmationCodeWidgetState();

  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String getEnteredCode() {
    if (_formKey.currentState!.validate()) {
      String code = "";

      controllers.forEach((element) {
        code += element.text;
      });

      print(code);
      return code;
    } else
      return "0";
  }
}

class _ConfirmationCodeWidgetState extends State<ConfirmationCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          confirmationCodeField(widget.controllers.elementAt(0)),
          confirmationCodeField(widget.controllers.elementAt(1)),
          confirmationCodeField(widget.controllers.elementAt(2)),
          confirmationCodeField(widget.controllers.elementAt(3)),
        ],
      ),
    );
  }

  Widget confirmationCodeField(TextEditingController controller) {
    return Container(
      height: 60,width: 60,
          child: TextFormField(
            controller: controller,
            maxLength: 1,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: '*',
              filled: true,
              fillColor: Colors.grey.withOpacity(0.08),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,

          ));

  }
}

