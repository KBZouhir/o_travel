import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAd extends StatefulWidget {
  const ShowAd({Key? key}) : super(key: key);

  @override
  _ShowAdState createState() => _ShowAdState();
}

class _ShowAdState extends State<ShowAd> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
      ),
      body: Stack(
        children: [
          Expanded(
            child: Center(
                child: CachedNetworkImage(
              imageUrl:
                  'https://i.pinimg.com/originals/6d/da/c4/6ddac42ba8f9b79fa5ddd86f4e051e2d.jpg',

              placeholder: (context, url) => Center(
                  child: Container(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ))),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            )),
          ),
          if (!show)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    show = true;
                  });
                },
                child: Container(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      'More Details',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.7,
                width: size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          show = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: size.width,
                        child: Center(
                          child: Text(
                            'Less Details',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
