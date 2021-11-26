import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/screens/ads/show.dart';

class AdsContainer extends StatelessWidget {
  const AdsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

class AdWidget extends StatefulWidget {
  final String image;

  const AdWidget({Key? key, required this.image}) : super(key: key);

  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowAd(image:widget.image)));
      },
      onDoubleTap: () {
        setState(() {
          favorite = true;
        });
      },
      child: Container(
        constraints: new BoxConstraints(
          minHeight: 120.0,
        ),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            Hero(
              tag: 'ad_image'+widget.image,
              child:
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) => Container(
                      width: 50,
                      height: 50,
                      child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ))),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              )
            ),
            Positioned(
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Text(
                            'Bousna',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Positioned(
                        height: 15,
                        width: 40,
                        bottom: 0,
                        left: 0,
                        child: Center(
                          child: Text(
                            '300 \$',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    Positioned(
                        height: 23,
                        width: 30,
                        bottom: 0,
                        right: 0,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.chat_outlined,
                              color: Colors.black,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        )),
                  ],
                ),
              )),
              bottom: 0,
              right: 0,
              left: 0,
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (favorite) ? Colors.red : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    favorite = !favorite;
                  });
                },
              ),
              top: 5,
              right: 5,
            )
          ],
        ),
      ),
    );
  }
}
