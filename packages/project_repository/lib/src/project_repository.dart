
import 'package:http/http.dart' as http;

class ProjectRepository {
  Future<http.Response> fetchProjects(String accessToken) async {
    final response = await http.get(Uri.parse("https://tracker.svmatrix.com/api/projects"), headers:  {
      "Authorization": "Bearer $accessToken"
    });
    print(response.body);
    return response;
  }

  Future<http.Response> deleteProject(String accessToken, int id) async {
    final response = await http.get(Uri.parse("https://tracker.svmatrix.com/api/project/destroy/$id"), headers: {
      "Authorization": "Bearer $accessToken"
    });

    return response;
  }
}