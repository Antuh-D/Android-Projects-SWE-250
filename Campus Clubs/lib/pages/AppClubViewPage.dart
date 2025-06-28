import 'dart:convert';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/HighlightItem.dart';
import '../config/ClubModel.dart';
import '../config/UserProvider.dart';
import '../styles/AppColors.dart';
import 'AppEventDetailPage.dart';

class AppClubViewPage extends StatefulWidget {
  final ClubModel club;

  const AppClubViewPage({Key? key, required this.club}) : super(key: key);

  @override
  State<AppClubViewPage> createState() => _AppClubViewPageState();
}

class _AppClubViewPageState extends State<AppClubViewPage> {
  List<dynamic> upcomingEvents = [];
  List<dynamic> closedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/events.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);
      // print('Loaded JSON string: $jsonString');

      setState(() {
        upcomingEvents = jsonResponse['upcoming'] ?? [];
        closedEvents = jsonResponse['closed'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading events JSON: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        Headding: widget.club.name,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            buildHeroSection(),
            buildHighlightsSection(),
            buildEventsSection(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: (){},
                child: Text("See All"),
              ),
            ),
            buildCloseEventsSection(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: (){},
                child: Text("See All"),
              ),
            ),
            buildCTASection(),


            Divider(thickness: 1,),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth/2-150 ),
              child: buildFooter(),
            ),

          ],
        ),
      ),
    );
  }

  //heading image
  Widget buildHeroSection() {
    return Stack(
      children: [
        if (widget.club.image.isNotEmpty)Image.memory(
          base64Decode(widget.club.image),
          width: double.infinity,
          height: 320,
          fit: BoxFit.cover,
        ),
        Container(
          height: 320,
          color: AppColors.primaryColor.withOpacity(0.6),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.club.subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentPink),
                    child: const Text("Follow Us"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  //about us
  Widget buildHighlightsSection() {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
      child: Column(
        children: [
          Text("About us",
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const Divider( thickness: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HighlightItem(icon: Icons.groups, title: "500+", subtitle: "Followers"),
              HighlightItem(icon: Icons.event, title: "7", subtitle: "Annual Events"),
              HighlightItem(icon: Icons.fitness_center, title: "100+", subtitle: "Active Members"),
              HighlightItem(icon:Icons.category ,title: widget.club.category,subtitle: "Category",)
             // HighlightItem(icon: Icons.emoji_events, title: "30+", subtitle: "Trophies Won"),
            ],
          ),
        ],
      ),
    );
  }

  //upcoming events
  Widget buildEventsSection() {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16,top: 15, bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Upcoming Events",
                  style: GoogleFonts.montserrat(
                      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
              Spacer(),
              //if(user?.role=='admin')
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.eventcreate);

                },
                  child: Text("Create New",style:GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor) ,))
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(upcomingEvents.length==0?0:4, (index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentPink,
                  child: Text(
                    '${(index + 1) * 5}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(upcomingEvents[index]['title'],),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.teal),
                        Text(
                          '${upcomingEvents[index]['date'] ?? ''} at ${upcomingEvents[index]['time'] ?? ''}',
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppEventDetailPage(event: upcomingEvents[index]),
                    ),
                  );
                }, child:Text("Register")),
              )
            );
          }),
        ],
      ),
    );
  }

  //closed events
  Widget buildCloseEventsSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16,top: 5, bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Closed Events",
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
          const SizedBox(height: 10),
          ...List.generate(closedEvents.length==0?0:2, (index) {
            return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      '${(index + 1) * 5}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(closedEvents[index]['title'],),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.teal),
                          Text(
                            '${closedEvents[index]['date'] ?? ''} at ${closedEvents[index]['time'] ?? ''}',
                            style: TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppEventDetailPage(event: closedEvents[index]),
                      ),
                    );
                  }, child:const Text("Register Closed")),
                )
            );
          }),
        ],
      ),
    );
  }

  Widget buildTeamsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Our Teams",
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Image.asset(upcomingEvents[index]['image']!, height: 80, fit: BoxFit.cover),
                    const SizedBox(height: 6),
                    Text(upcomingEvents[index]['title']!, style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                    TextButton(onPressed: () {}, child: const Text("View Schedule")),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //"Get Membership"
  Widget buildCTASection() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Container(
        width: double.infinity,
        color: AppColors.accentPink.withOpacity(0.2),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Join With Our Community",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.club.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPink,
              ),
              child: const Text("Get Membership"),
            )
          ],
        ),
      ),
    );
  }


  //Footer
  Widget buildFooter() {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.facebook),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.device_hub),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.email),
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text("© 2025 University Club. All rights reserved.",
            style: GoogleFonts.openSans(color: Colors.grey)),
      ],
    );
  }

}
