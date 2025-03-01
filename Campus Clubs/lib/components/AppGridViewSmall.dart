import 'package:flutter/material.dart';

import 'DisplayCardSmall.dart';

class AppGridViewSmall extends StatelessWidget {
  final List<dynamic> cardData;
  final int cardsPerRow;
  final double cardHeight;
  final double cardWidth;
  final double spacing;
  final double childAspectRatio;

  const AppGridViewSmall({
    super.key,
    required this.cardData,
    required this.cardsPerRow,
    required this.cardHeight ,
    required this.spacing ,
    required this.childAspectRatio, required this.cardWidth,
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
            child: DisplayCardSmall(
              height: cardHeight,
              width : cardWidth,
              imagePath: cardData[index]['image']!,
              title: cardData[index]['name']!,
              subtitle: cardData[index]['subtitle'],
              followers: cardData[index]['followers'],
              onTap: () {
      
              },
            ),
          );
        },
      ),
    );
  }

}