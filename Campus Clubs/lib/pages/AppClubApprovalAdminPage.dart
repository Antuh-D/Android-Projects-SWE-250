import 'dart:convert';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppClubApprovalAdminPage extends StatefulWidget {
  const AppClubApprovalAdminPage({super.key});

  @override
  State<AppClubApprovalAdminPage> createState() => _AppClubApprovalAdminPageState();
}

class _AppClubApprovalAdminPageState extends State<AppClubApprovalAdminPage> {
  List<dynamic> requests = [];

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    final url = Uri.parse('${dotenv.env['API_URL']}/api/approval');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          requests = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print("Fetch error: $e");
    }
  }

  Future<void> updateStatus(String id, String status) async {
    print(id);
    final url = Uri.parse('${dotenv.env['API_URL']}/api/approval/$id');
    try {
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status": status}),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to $status')),
        );
        fetchRequests();
      }
    } catch (e) {
      print("Update error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        Headding:'Pending Club Approvals' ,
        backpage: true,
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final item = requests[index];
          if (item==null) return SizedBox(); // Show only pending

          return Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Club: ${item['clubname']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Category: ${item['category']}"),
                  Text("President: ${item['president']}"),
                  Text("Contact No: ${item['contract']}"),
                  SizedBox(height: 8),
                  Text("Application:\n${item['applicationText']}"),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (item['status'] == "pending") ...[
                        TextButton(
                          onPressed: () => updateStatus(item['_id'], 'rejected'),
                          child: Text('Reject', style: TextStyle(color: Colors.red)),
                        ),
                        ElevatedButton(
                          onPressed: () => updateStatus(item['_id'], 'approved'),
                          child: Text('Approve'),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
