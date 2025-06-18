
import 'package:http/http.dart' as http;

class TasksRepository {
  Future<http.Response> getTasksAndSections(int id, String accessToken) async {
    final response = await http.get(Uri.parse("https://tracker.svmatrix.com/api/projects/show/$id"), headers:  {
      "Authorization": "Bearer $accessToken"
    });
    print(response.body);
    return response;
  }
}