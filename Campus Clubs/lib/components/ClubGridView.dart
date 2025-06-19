import 'package:flutter/material.dart';
import '../config/ClubModel.dart';
import '../pages/AppClubViewPage.dart';

class ClubGridView extends StatelessWidget {
  final List<ClubModel> cardData;
  final int cardsPerRow;
  final double cardHeight;
  final double spacing;
  final double childAspectRatio;
  //final double? cardWidth;
  //final int number;

  const ClubGridView({
    Key? key,
    required this.cardData,
    this.cardsPerRow = 1,
    this.cardHeight = 160,
    this.spacing = 10,
   // this.cardWidth,
    this.childAspectRatio = 1 / 1.2,
  //  required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (spacing * (cardsPerRow + 1))) / cardsPerRow;
    final dynamicChildAspectRatio = cardWidth / cardHeight;

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
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppClubViewPage(club: club),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: cardHeight,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      club.image,
                      width: 100,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          club.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          club.subtitle,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.people, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${club.members} members'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
