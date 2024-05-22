import 'package:flutter/material.dart';
import 'package:two_kang_haircut/util/chatgpt_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService _chatGPTService = ChatGPTService('sk-proj-mSazsDJGN81rCx8LnmEET3BlbkFJxGJT2fy0WKIg4VsrIr2x');
  String _response = '';

  void _sendMessage() async {
    final userInput = _controller.text;
    final response = await _chatGPTService.getResponse(userInput, '');
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your message'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            Text('Response: $_response'),
          ],
        ),
      ),
    );
  }
}
