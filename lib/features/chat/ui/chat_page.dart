import 'package:chat_app/core/helper/constants.dart';
import 'package:chat_app/core/widgets/chat_buble.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();
  final secureStorage = const FlutterSecureStorage();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  Future<String?> fetchEmail() async {
    return await secureStorage.read(key: 'email');
  }

  void _sendMessage(String message) async {
    final email = await fetchEmail();
    if (email != null && message.isNotEmpty) {
      messages.add(
        {
          kMessage: message,
          kCreatedAt: DateTime.now(),
          kID: email,
        },
      );
      controller.clear();
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: fetchEmail(),
      builder: (context, emailSnapshot) {
        if (emailSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final email = emailSnapshot.data;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kLogo,
                  height: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Chat Duo',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.hasData) {
                List<Message> messagesList = snapshot.data!.docs
                    .map((doc) =>
                        Message.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble(message: messagesList[index])
                              : ChatBubbleForFriend(
                                  message: messagesList[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomFormTextField(
                        controller: controller,
                        onSubmitted: _sendMessage,
                        inputDecoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: GestureDetector(
                            child: const Icon(
                              Icons.send,
                              color: kPrimaryColor,
                            ),
                            onTap: () {
                              _sendMessage(controller.text);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('please Enter a message'));
              }
            },
          ),
        );
      },
    );
  }
}
