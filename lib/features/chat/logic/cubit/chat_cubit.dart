import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helper/constants.dart';
import 'package:chat_app/features/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessages({required String message, required String email}) {
    try {
      messages.add(
        {
          kMessage: message,
          kCreatedAt: DateTime.now(),
          kID: email,
        },
      );
    } catch (e) {
      log("error is$e");
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
