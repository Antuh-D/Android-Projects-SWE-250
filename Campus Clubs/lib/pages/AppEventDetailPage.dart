import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

class AppEventDetailPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const AppEventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  _AppEventDetailPageState createState() => _AppEventDetailPageState();
}

class _AppEventDetailPageState extends State<AppEventDetailPage> {
  bool isInterested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: widget.event['title'],
        backpage: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.event['image'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    widget.event['title'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // Club and Category
                  Text(
                    "${widget.event['club']} • ${widget.event['category']}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 12),

                  // Date and Time
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 18, color: Colors.blue),
                      const SizedBox(width: 6),
                      Text("${widget.event['date']} at ${widget.event['time']}",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 18, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      Text(widget.event['location'], style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.event['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // Interest Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isInterested = !isInterested;
                  });

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(isInterested
                  //         ? 'Marked as Interested!'
                  //         : 'Interest Removed!'),
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.star,
                  color: isInterested ? Colors.yellowAccent : Colors.white,
                  size: isInterested ? 30 : 24,
                  shadows: isInterested
                      ? [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.yellow,
                      offset: Offset(0, 0),
                    )
                  ]
                      : [],
                ),
                label: Text(
                  isInterested ? 'Interested' : 'Mark as Interested',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: isInterested ? Colors.teal[800 ] : Colors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
