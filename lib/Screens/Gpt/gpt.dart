
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const gemini = "AIzaSyA5kM6ZGeVjpNpWdLyt44T81ymOtzLvUVg";

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final Gemini gemini = Gemini.instance;

  final ChatUser current = ChatUser(id: '1', firstName: 'User', lastName: 'Sender');
  final ChatUser geminiUser = ChatUser(
      id: '2',
      firstName: '',
      lastName: 'Gemini',
      profileImage: 'assets/icons/gemini2.png'
  );

  List<ChatMessage> message = <ChatMessage>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Gemini', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: DashChat(
        currentUser: current,
        onSend: _sentMessage,
        messages: message,
      ),
    );
  }

  void _sentMessage(ChatMessage chatMessage) {
    setState(() {
      message = [chatMessage, ...message];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = message.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage=message.removeAt(0);
          String response = event.content?.parts?.map((part) => part.text)?.fold("",(previous,current)=>"$previous$current") ?? "";
          lastMessage.text+=response;
          setState(() {
            message=[lastMessage!,...message];
          });
        }
        else {
          String response = event.content?.parts?.map((part) => part.text)?.fold("",(previous,current)=>"$previous$current") ??  "";
          ChatMessage messag = ChatMessage(user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(()
          {
            message = [messag, ...message];
          });
        }
      });
    } catch (c) {
      print(c);
    }
  }
}
