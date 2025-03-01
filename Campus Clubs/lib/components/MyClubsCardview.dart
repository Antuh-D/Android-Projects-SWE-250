import 'package:flutter/material.dart';

class MyClubsCardView extends StatelessWidget {
  final double? width;
  final double? height;
  final String imagePath;
  final String title; // Made non-nullable since it's required
  final String? subtitle;
  final VoidCallback onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String ?category;
  final int ?members;
  final int ?followers;

  const MyClubsCardView( {
    super.key,
    this.width,
    this.height,
    required this.imagePath,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.titleStyle,
    this.subtitleStyle, this.category, this.members, this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Title, Subtitle, and Price Section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          title,
                          style: titleStyle ?? const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Subtitle
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: subtitleStyle ??const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10,),

                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              "Followers: ${followers ?? 0}+", // Display the follower count
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            "Joined Members: ${followers ?? 0}+", // Display the follower count
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          )
                      ],
                    ),
                  ),
                ),

                // Image Section
                Flexible(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      imagePath,
                      height: height,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}