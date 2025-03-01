import 'package:flutter/material.dart';

class NavigateSlide extends StatelessWidget {
  final bool isRight;
  final VoidCallback onPressed;

  const NavigateSlide({
    Key? key,
    required this.isRight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: isRight ? 10 : null,
      left: isRight ? null : 10,
      top: MediaQuery.of(context).size.height * 0.4,
      child: IconButton(
        icon: Icon(
          isRight
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_new_outlined,
          size: 30,
          color:Colors.grey,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
