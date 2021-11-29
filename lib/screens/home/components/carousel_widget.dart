
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/components/carousel_item_widget.dart';


class CarouselWidget extends StatefulWidget {
  final List<Offer> offerList;
  const CarouselWidget({Key? key,required this.offerList }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {


    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    return Column(children: <Widget>[
      CarouselSlider(
        options: CarouselOptions(
            height: 200,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.bounceIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: widget.offerList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return CarouselItemWidget(offer: i);
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          widget.offerList,
              (index, url) {
            return Container(
              width: _current == index ? 20 : 8,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal:2,vertical: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color:
                  _current == index ? primaryColorDark : primaryColorLite),
            );
          },
        ),
      ),
    ]);
  }
}



