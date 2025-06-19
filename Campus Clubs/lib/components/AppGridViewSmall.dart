import 'package:flutter/material.dart';
import 'package:campusclubs/config/ClubModel.dart';
import '../pages/AppClubViewPage.dart';
import 'DisplayCardSmall.dart';

class AppGridViewSmall extends StatelessWidget {
  final List<ClubModel> cardData;
  final int cardsPerRow;
  final double cardHeight;
  final double cardWidth;
  final double spacing;
  final double childAspectRatio;

  const AppGridViewSmall({
    Key? key,
    required this.cardData,
    required this.cardsPerRow,
    required this.cardHeight,
    required this.cardWidth,
    required this.spacing,
    required this.childAspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final adjustedCardWidth = (screenWidth - (spacing * (cardsPerRow + 1))) / cardsPerRow;
    final dynamicChildAspectRatio = adjustedCardWidth / cardHeight;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cardData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cardsPerRow,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: dynamicChildAspectRatio,
      ),
      itemBuilder: (context, index) {
        final club = cardData[index];
        return SizedBox(
          height: cardHeight,
          child: DisplayCardSmall(
            height: cardHeight,
            width: adjustedCardWidth,
            imagePath: club.image,
            title: club.name,
            subtitle: club.subtitle,
            followers: club.followers,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => AppClubViewPage(club: club),
              )
              );
            },
          ),
        );
      },
    );
  }
}
