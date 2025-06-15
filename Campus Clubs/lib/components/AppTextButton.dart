import 'package:flutter/material.dart';

class AppTextButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  
  const AppTextButton({super.key, required this.child, this.onPressed});

  @override
  State<AppTextButton> createState() => _ApptextbuttonState();
}

class _ApptextbuttonState extends State<AppTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Row(
          children: [
            widget.child,
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,size: 20,),
          ],
        ),
      ),
    );
  }
}
