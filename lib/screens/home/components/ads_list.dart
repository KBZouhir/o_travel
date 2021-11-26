import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';

class AdsList extends StatelessWidget {
  final adsList;

  const AdsList({
    Key? key,
    required this.adsList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount:4,
      itemCount: adsList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          Container( child: AdWidget(image: adsList[index])),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }
}
