import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdsContainer extends StatelessWidget {
  const AdsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AdWidget(full: false),
            Spacer(),
            AdWidget(full: false),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        AdWidget(full: true),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class AdWidget extends StatefulWidget {
  final bool full;

  const AdWidget({Key? key, required this.full}) : super(key: key);

  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          favorite = true;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.6,
        width: widget.full
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: widget.full
            ? EdgeInsets.symmetric(horizontal: 20.0)
            : EdgeInsets.symmetric(horizontal: 0.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl:
                    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/tourism-and-spa-retreat-magazine-ad-design-template-995fd9fa2768402717ab5156e373cd2b_screen.jpg?ts=1584446948',
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
                height: 1000,
              ),
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
