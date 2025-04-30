import 'dart:convert';
import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart'; // For HttpService
import '../models/chat.dart';

class ApiService {
  final HttpService _httpService;

  ApiService(this._httpService) {
    _httpService.loadToken();
  }

  Future<Map<String, dynamic>> fetchConversationByOrderId(
    String orderId,
  ) async {
    try {
      final response = await _httpService.getRequest(
        '/orders/$orderId/conversation',
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'conversationId':
              data['conversationDetails']['conversationId'] as String,
          'name': data['conversationDetails']['name'] as String,
          'messages':
              (data['conversationDetails']['messages'] as List)
                  .map((json) => Chat.fromJson(json))
                  .toList(),
        };
      } else {
        throw Exception(
          'Failed to fetch conversation: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch conversation: $e');
    }
  }

  Future<List<Chat>> fetchChats(String conversationId) async {
    try {
      final response = await _httpService.getRequest(
        '/conversations/$conversationId/messages',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Chat.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch chats: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch chats: $e');
    }
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderModel,
    required String text,
  }) async {
    try {
      final response = await _httpService
          .postRequest('/conversations/$conversationId/messages', {
            'conversation': conversationId,
            'sender': senderId,
            'senderModel': senderModel,
            'text': text,
          });
      if (response.statusCode != 201) {
        throw Exception(
          'Failed to send message: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> markMessageAsRead(
    String conversationId,
    String messageId,
  ) async {
    try {
      final response = await _httpService.patchRequest(
        '/conversations/$conversationId/messages/$messageId',
        {'status': 'read'},
      );
      if (response.statusCode != 200) {
        throw Exception(
          'Failed to mark message as read: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }
}
