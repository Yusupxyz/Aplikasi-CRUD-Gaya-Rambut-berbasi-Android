// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey;

  ChatGPTService(this.apiKey);

  Future<String> getResponse(String userInput, String urlImage) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'gpt-4o',
      'messages': [
        {
      "role": "user",
      "content": [
        {"type": "text", "text": userInput},
        {
          "type": "image_url",
          "image_url": {
            "url": urlImage,
          },
        },
      ],
    }
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final message = data['choices'][0]['message']['content'];
      print(message);
      return message;
    } else {
      throw Exception('Failed to load response');
    }
  }
}
