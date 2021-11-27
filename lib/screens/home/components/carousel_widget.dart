
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/components/carousel_item_widget.dart';


class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://s3.amazonaws.com/tasmeemme.project.mi.thumbnails/resize_805x9000/480/347480.jpg',
      'https://mir-s3-cdn-cf.behance.net/projects/404/998f63122135473.Y3JvcCwxMjM3LDk2NywwLDk.png',
      'https://scontent.fczl1-2.fna.fbcdn.net/v/t1.6435-9/186913311_841269306598087_4984690488485274619_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=e3f864&_nc_eui2=AeFbfYWc9rSG4qx3LixIsAKNvpNmB0ybLfK-k2YHTJst8udnil_YCVt5qZIOmfquRG0hcvj6CZumn4BRZbst_Ika&_nc_ohc=jpZptMgpt0QAX9ZCcbT&_nc_ht=scontent.fczl1-2.fna&oh=58a3a93a97c4bc0b48f39d323cfea0a9&oe=61AC50C9',
    ];

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
        items: imgList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return CarouselItemWidget(item: i);
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
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



