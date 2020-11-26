import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class API {
  String hostname = "http://192.168.1.104:8069/api/";

  // Future<http.Response> register(String phoneNumber, String password) async {
  //   return await http.post(
  //     hostname + 'signup',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(
  //         <String, dynamic>{"phone": phoneNumber, "password": password}),
  //   );
  // }

  Future<http.Response> login(String email, String password) async {
    return await http
        .post(
          hostname + 'login',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "email": email,
            "password": password,
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> logout() async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http.post(
      hostname + 'logout',
      headers: {
        "accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    ).timeout(
      Duration(seconds: 10),
    );
  }

  Future<http.Response> getAllUser(int groupId, int inner) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http.get(
      hostname + 'user/group/' + groupId.toString() + '/' + inner.toString(),
      headers: {
        "accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    ).timeout(
      Duration(seconds: 10),
    );
  }

  Future<http.Response> getProfile(int userId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http.get(
      hostname + 'user/' + userId.toString() +'/profile',
      headers: {
        "accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    ).timeout(
      Duration(seconds: 10),
    );
  }

  Future<http.Response> leaveGroup(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'user/leave/' + groupId.toString(),
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> getListGroup() async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http.get(
      hostname + 'group/list',
      headers: {
        "accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    ).timeout(
      Duration(seconds: 10),
    );
  }  

  Future<http.Response> addPost(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/post/register',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
            // "email": email,
            // "password": password,
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> delPost(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/post/delete',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
            // "email": email,
            // "password": password,
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> getComment(int groupId, int postId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .get(
          hostname + 'group/' + groupId.toString() + '/post/' + postId.toString() + '/comment',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> sendComment(int groupId, int postId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/post/' + postId.toString() + '/comment/new',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body:jsonEncode({

          })
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> delComment(int groupId, int postId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/post/' + postId.toString() + '/comment/delete',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            
          })
        )
        .timeout(
          Duration(seconds: 10),
        );
  }
}

class APIAdmin extends API {
  Future<http.Response> makeGroup() async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          super.hostname + 'group/register',
          headers: {
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            // "email": email,
            // "password": password,
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> addUser(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/add',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> removeUser(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/remove',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> deleteGroup(int groupId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'group/' + groupId.toString() + '/delete',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(<String, dynamic>{
          }),
        )
        .timeout(
          Duration(seconds: 10),
        );
  }
}

class APIChat extends API{
  Future<http.Response> initChat() async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'chat/init',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            //userId
          })
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> getChat(int chatId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .get(
          hostname + 'chat/' + chatId.toString(),
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
        )
        .timeout(
          Duration(seconds: 10),
        );
  }

  Future<http.Response> sendMessage(int chatId) async {
    String token = await FlutterSecureStorage().read(key: 'token');
    return await http
        .post(
          hostname + 'chat/' + chatId.toString() + '/send',
          headers: <String, String>{
            "accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            //message
          })
        )
        .timeout(
          Duration(seconds: 10),
        );
  }
}