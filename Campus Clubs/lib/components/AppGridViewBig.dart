import 'package:flutter/material.dart';

import 'DisplayCardSmall.dart';
import 'MyClubsCardview.dart';

class AppGridViewBig extends StatelessWidget {
  final List<dynamic> cardData;
  final int cardsPerRow;
  final double cardHeight;
  final double spacing;
  final double childAspectRatio;

  const AppGridViewBig({
    super.key,
    required this.cardData,
    required this.cardsPerRow,
    required this.cardHeight ,
    required this.spacing ,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (spacing * (cardsPerRow + 1))) / cardsPerRow;
    final dynamicChildAspectRatio = cardWidth / cardHeight;

    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cardsPerRow,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: dynamicChildAspectRatio,
        ),
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: cardHeight,
            child: MyClubsCardView(
              height: cardHeight,
              imagePath: cardData[index]['image'],
              title: cardData[index]['name'] ,
              subtitle: cardData[index]['subtitle'] ,
              members: cardData[index]['members'] ,
              followers: cardData[index]['followers'],
              category: cardData[index]['category'],
              onTap: () {

              },),
          );
        },
      ),
    );
  }

}