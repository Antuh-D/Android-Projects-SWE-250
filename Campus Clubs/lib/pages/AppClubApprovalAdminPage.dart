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
                  Text("Contact Email: ${item['contract']}"),
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
                          onPressed: () async {
                            bool isApproved = await updateStatus(item['_id'], 'approved');
                            if (isApproved) {
                              await fetchUserByEmail(item['contract']);
                            }
                          },
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

  Future<bool> updateStatus(String id, String status) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/api/approval/$id');
    try {
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status": status}),
      );
      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated ')),
        );
        fetchRequests();
         return true;
      } else {
        print("Status update failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Update error: $e");
      return false;
    }
  }


  Future<void> fetchUserByEmail(String email) async {
    final url = Uri.parse("${dotenv.env['API_URL']}/api/user/$email");

    try {
      final response = await http.get(url);
      print("User fetch body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String userId = data['_id'];
        await updateUserRole(userId);
      } else {
        print("Failed to find president: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching user: $error");
    }
  }


  Future<void> updateUserRole(String userId) async {
    final String URL = "${dotenv.env['API_URL']}/api/updateprofile";
    final url = Uri.parse(URL);
    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "_id": userId,
          "role": "admin",
        }),
      );
      print("Role update response: ${response.body}");
      if (response.statusCode == 200) {
        print("User role updated to admin");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User role updated')),
        );
      } else {
        print("Failed to update role: ${response.body}");
      }
    } catch (e) {
      print("Role update error: $e");
    }
  }


}
