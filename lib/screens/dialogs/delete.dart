import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';

class DeleteDialog extends StatelessWidget {
  final int offerId;

  const DeleteDialog( {Key? key,required this.offerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: 200,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(raduice))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  height: 130,
                  padding: EdgeInsets.only(top: 30,left:20,right: 20),
                  child: Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'delete'),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        getTranslated(context, 'delete_message'),
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).colorScheme.secondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                              ),

                              height: 60,
                              child:Center(
                                child:  Text(
                                  getTranslated(context, 'cancel'),
                                  style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              deleteOffer(offerId).then((value){
                                if (value) Navigator.pop(context);
                                else Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,),

                              child:Center(
                                child:  Text(
                                  getTranslated(context, 'yes'),
                                  style: TextStyle(fontSize: 20,color:Colors.white),
                                ),
                              ),
                            )),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
