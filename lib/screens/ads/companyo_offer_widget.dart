import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/screens/ads/edit.dart';
import 'package:o_travel/screens/ads/show.dart';
import 'package:o_travel/screens/dialogs/delete.dart';


class CompanyOfferWidget extends StatefulWidget {
  final Offer offer;

  const CompanyOfferWidget({Key? key, required this.offer}) : super(key: key);

  @override
  _CompanyOfferWidgetState createState() => _CompanyOfferWidgetState();
}

class _CompanyOfferWidgetState extends State<CompanyOfferWidget> {
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
                    child: Row(
                      children: [
                        Expanded(child:  IconButton(
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                      onPressed: () {
                        showDialog(context: context,barrierColor: Colors.white38, builder: (_) => DeleteDialog(offerId: widget.offer.id,));
                      }),),Expanded(child:  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 25,
                    ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditAdScreen(offer: widget.offer,)));
                      }),),
                      ],
                    ),
                  )),
              bottom: 0,
              right: 0,
              left: 0,
            ),
          ],
        ),
      ),
    );
  }
}
