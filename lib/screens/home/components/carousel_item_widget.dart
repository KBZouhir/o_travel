
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselItemWidget extends StatefulWidget {
  final String item;

  const CarouselItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _CarouselItemWidgetState createState() => _CarouselItemWidgetState();
}

class _CarouselItemWidgetState extends State<CarouselItemWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          favorite = !favorite;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: widget.item,
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
            Positioned(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Bousna',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      '300 \$',
                      style: TextStyle(fontSize: 22, color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.chat_outlined,
                        color:  Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: 5,
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
