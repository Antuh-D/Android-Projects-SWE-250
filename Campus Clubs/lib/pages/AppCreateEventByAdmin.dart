import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:campusclubs/config/AppURL.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:campusclubs/components/AppEventTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../components/AppTextField.dart';
import '../components/MyAppBar.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';

class AppCreateEventByAdmin extends StatefulWidget {
   AppCreateEventByAdmin({super.key});

  @override
  State<AppCreateEventByAdmin> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<AppCreateEventByAdmin> {
  final List<String> cate_list = ['Technology', 'Art & Media', 'Business', 'Literature', 'Culture', 'Sports', 'Theatre', 'Academics', 'Environment', 'Entertainment', 'Art', 'Science', 'Communication', 'Food',];

  final TextEditingController title = TextEditingController();
  final TextEditingController club = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  String? category;

  Uint8List? imageBytes;
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          Headding: "Create Event",
          backpage: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppURL.event, height: 150)),
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
                  "Add Your Event",
                  style: AppTexts.AppHeading,
                )
              ],
            ),

            Divider(thickness: 1,),
            SizedBox(height: 30,),
            AppEventTextField(
              label: "1. Event Title",
              controller: title,
              hint: "Enter event title",
            ),
            SizedBox(height: 16),
            AppEventTextField(
              label: "2. Club Name",
              controller: club,
              hint: "",
              icon: Icons.group,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3. Select One", style: AppTexts.normal),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    items: cate_list
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value as String?;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Club Category",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black38, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    dropdownColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildDateTimePickers(),
            AppEventTextField(
              label: "6. Location",
              controller: location,
              hint: "Event location",
              icon: Icons.location_on,
            ),
            SizedBox(height: 16),
            AppEventTextField(
              label: "7. Description",
              controller: description,
              hint: "Brief details about the event",
              maxLines: 4,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTextButton(
                    labelText: "8. Upload Event Image",
                    iconAsset: Icon(Icons.image, color: AppColors.icon2, size: 25),
                    textStyle: AppTexts.normal,
                    onPressed: pickImage,
                  ),
                  if (imageFile != null) Text("${imageFile!.path}"),
                  if (imageBytes != null) Text("Image uploaded successfully"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size.fromHeight(45),
                ),
                child: Text("Submit Event", style: AppTexts.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePickers() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("4. Date", style: AppTexts.normal),
          SizedBox(height: 5),
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: AppTextField(hint: "YYYY-MM-DD", controller: date),
            ),
          ),
          SizedBox(height: 16),
          Text("5. Time", style: AppTexts.normal),
          SizedBox(height: 5),
          GestureDetector(
            onTap: _pickTime,
            child: AbsorbPointer(
              child: AppTextField(hint: "HH:MM", controller: time),
            ),
          ),
        ],
      ),
    );
  }

  Widget CreateTextButton({
    required VoidCallback onPressed,
    required String labelText,
    required Widget iconAsset,
    required TextStyle textStyle,
  }) {
    return Row(
      children: [
        Flexible(child: Text("$labelText           ", style: textStyle)),
        TextButton(
          onPressed: onPressed,
          child: iconAsset,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          imageBytes = bytes;
          imageFile = null;
        });
      } else {
        setState(() {
          imageFile = File(pickedFile.path);
          imageBytes = null;
        });
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      date.text = picked.toIso8601String().split("T").first;
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      time.text = "$hour:$minute";
    }
  }

  void _submit() {
    if (title.text.isEmpty || club.text.isEmpty || category==null || date.text.isEmpty || time.text.isEmpty || location.text.isEmpty || description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    String? base64Image;
    if (imageBytes != null) {
      base64Image = base64Encode(imageBytes!);
    }

    final newEvent = {
      "title": title.text.trim(),
      "club": club.text.trim(),
      "category": category,
      "date": date.text.trim(),
      "time": time.text.trim(),
      "location": location.text.trim(),
      "description": description.text.trim(),
      "image": base64Image ?? "",
    };
    //Navigator.pop(context, newEvent);
    submitToBackend(newEvent);
  }

  Future<void> submitToBackend(Map<String, dynamic> eventData) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/api/events');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(eventData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Event created successfully!")),
        );
        Navigator.pop(context);
      } else {
        // Try to decode error message from backend
        final errorMsg = jsonDecode(response.body)['error'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $errorMsg")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to backend.")),
      );
      print("Error: $e");
    }
  }

}
