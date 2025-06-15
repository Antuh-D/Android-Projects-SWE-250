import 'package:campusclubs/components/AppTextField.dart';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';

class AppClubApprovalPage extends StatefulWidget {
  const AppClubApprovalPage({super.key});

  @override
  State<AppClubApprovalPage> createState() => _AppClubApprovalPageState();
}

class _AppClubApprovalPageState extends State<AppClubApprovalPage> {
  final application = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.clubApproval,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Theme and Heading
            Center(child: Image.asset(AppURL.loginTheme, height: 150)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppURL.mens_icon,
                  height: 30,
                  width: 30,
                  color: Colors.black,
                ),
                Text(
                  "Your Club",
                  style: AppTexts.AppHeading,
                )
              ],
            ),

            Divider(thickness: 1,),


            //Application form
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: AppTextField(hint: "Club Name", controller:application ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child: Text(
                "Write your application to request varsity authority approval for creating a new club.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Type your application...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.black38,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor:Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: DropdownButtonFormField(
                items: ["Tech", "Culture", "Sports"]
                    .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,
                     // style:TextStyle(color: Colors.teal, fontSize: 16,),
                    )
                )
                )
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(labelText: "Club Category",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor:Colors.white.withOpacity(0.9),

                ),
                dropdownColor: Colors.white,
              ),
            ),

            //submit
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Submit logic here
                },
                child: Text("Submit",style: AppTexts.button,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
