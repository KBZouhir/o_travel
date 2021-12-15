import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/screens/ads/show.dart';

class OffersContainer extends StatelessWidget {
  const OffersContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

class OfferWidget extends StatefulWidget {
  final Offer offer;

  const OfferWidget({Key? key, required this.offer}) : super(key: key);

  @override
  _OfferWidgetState createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    favorite = widget.offer.favoriteByMe;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowOffer(offer: widget.offer)));
      },
      onDoubleTap: () {
        setState(() {
          if (!favorite) addToFavorites(widget.offer.id);
          favorite = true;
        });
      },
      child: Container(
        constraints: new BoxConstraints(
          minHeight: 120.0,
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
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            Hero(
                tag: 'offer${widget.offer.images[0].url}',
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: widget.offer.images[0].url,
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
                )),
            Positioned(
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Text(
                            (widget.offer.countries[0].name.length > 10)
                                ? widget.offer.countries[0].name
                                    .substring(0, 10)
                                : widget.offer.countries[0].name,
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
                            '${widget.offer.price} \$',
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
                    addToFavorites(widget.offer.id);
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
