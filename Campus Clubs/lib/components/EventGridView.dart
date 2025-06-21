import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/AppEventDetailPage.dart';

class EventGridView extends StatelessWidget {
  final List<dynamic> events;
  final int cardsPerRow;
  final double cardHeight;
  final double spacing;
  final int number;
  final bool isInsideScroll;

  const EventGridView({
    super.key,
    required this.events,
    required this.cardsPerRow,
    required this.cardHeight,
    required this.spacing,
    required this.number,
    this.isInsideScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (spacing * (cardsPerRow + 1))) / cardsPerRow;
    final childAspectRatio = cardWidth / cardHeight;

    return GridView.builder(
      shrinkWrap: isInsideScroll,
      physics: isInsideScroll ? NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.only(left: spacing, right: spacing, bottom: spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cardsPerRow,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: number,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(
          event: event,
          height: cardHeight,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppEventDetailPage(event: events[index]),
              ),
            );
          },
        );
      },
    );

  }
}

/// EventCard widget showing individual event data
class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final double height;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.event,
    this.height = 160,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double imageWidth = height * 1.2;

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Container(
          height: height,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              // Left side: text, take available width
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        event['title'] ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Text(
                        '${event['club'] ?? ''} • ${event['category'] ?? ''}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.teal),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${event['date'] ?? ''} at ${event['time'] ?? ''}',
                              style: TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              if (event['image'] != null && event['image'].toString().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    event['image'],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
              else
                SizedBox(width: 120),
            ],
          ),
        ),
      ),
    );
  }
}