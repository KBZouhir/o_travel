import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';

class OfferList extends StatelessWidget {
  final offerList;

  const OfferList({
    Key? key,
    required this.offerList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount:4,
      itemCount: offerList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          Container( child: OfferWidget(offer: offerList[index])),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }
}
