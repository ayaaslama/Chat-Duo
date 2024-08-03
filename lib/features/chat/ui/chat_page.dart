import 'package:chat_app/core/helper/constants.dart';
import 'package:chat_app/core/widgets/chat_buble.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> _fetchEmail() async {
    return await _secureStorage.read(key: 'email');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _fetchEmail(),
      builder: (context, emailSnapshot) {
        if (emailSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (emailSnapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${emailSnapshot.error}')),
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
                const SizedBox(width: 5),
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
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    var messagesList =
                        BlocProvider.of<ChatCubit>(context).messagesList;
                    return ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        final message = messagesList[index];
                        return message.id == email
                            ? ChatBubble(message: message)
                            : ChatBubbleForFriend(message: message);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomFormTextField(
                  controller: _textController,
                  onSubmitted: (data) {
                    if (email != null) {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessages(message: data, email: email);
                      _textController.clear();
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  inputDecoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: GestureDetector(
                      child: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      onTap: () {
                        final data = _textController.text;
                        if (email != null && data.isNotEmpty) {
                          BlocProvider.of<ChatCubit>(context)
                              .sendMessages(message: data, email: email);
                          _textController.clear();
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
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
          ),
        );
      },
    );
  }
}
