import 'package:flutter/material.dart';

class DisplayCardSmall extends StatelessWidget {
  final double height;
  final double width;
  final String ?imagePath;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final int ?followers;


  const DisplayCardSmall({
    super.key,
    required this.height,
    this.imagePath,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing, required this.width, required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: height*0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width for children
          children: [
            // Image at the top
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.asset(
                imagePath ?? 'assets/png/dataT.png' ,
                height: height*0.5 ,
                width: width * 0.5,

              ),
            ),
            // Column with text and favorite icon
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (trailing != null)
                    Align(
                      alignment: Alignment.centerRight, // Align trailing to the right
                      child: trailing!,
                    ),
                  SizedBox(height: 8,),
                  Text(
                    "Followers: ${followers ?? 0}+", // Display the follower count
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}