import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/screens/ads/show.dart';

class CarouselItemWidget extends StatefulWidget {
  final Offer offer;

  const CarouselItemWidget({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  _CarouselItemWidgetState createState() => _CarouselItemWidgetState();
}

class _CarouselItemWidgetState extends State<CarouselItemWidget> {
  late bool favorite;
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
          favorite = !favorite;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Stack(
          children: [
            Hero(
              tag: 'offer${widget.offer.images[0].url}',
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.offer.images[0].url,
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 1000,
                  placeholder: (context, url) => Container(
                      width: 50,
                      height: 50,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ))),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.offer.price} \$',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      (widget.offer.countries[0].name.length > 10)
                          ? widget.offer.countries[0].name.substring(0, 10)
                          : widget.offer.countries[0].name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              bottom: 0.2,
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
              left: 5,
            )
          ],
        ),
      ),
    );
  }
}
