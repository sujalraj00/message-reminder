// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class FbLogin extends StatefulWidget {
//   const FbLogin({Key? key}) : super(key: key);
//
//   @override
//   State<FbLogin> createState() => _FbLoginState();
// }
//
// class _FbLoginState extends State<FbLogin> {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool _checking = true;
//   List<dynamic> _friendsList = [];
//   List<dynamic> _photosList = [];
//   List<dynamic> _postsList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _checkIfIsLoggedIn();
//   }
//
//   _checkIfIsLoggedIn() async {
//     final accessToken = await FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     if (accessToken != null) {
//       print(accessToken.toJson());
//       final userData = await FacebookAuth.instance.getUserData();
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//       });
//       _fetchFriendsList();
//       _fetchPhotosList();
//       _fetchPostsList();
//     } else {
//       _login();
//     }
//   }
//
//   _login() async {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: ['public_profile', 'email', 'user_friends', 'user_photos', 'user_posts'],
//     );
//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       final userData = await FacebookAuth.instance.getUserData();
//       _userData = userData;
//       _fetchFriendsList();
//       _fetchPhotosList();
//       _fetchPostsList();
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//     setState(() {
//       _checking = false;
//     });
//   }
//
//   _logout() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//     _friendsList = [];
//     _photosList = [];
//     _postsList = [];
//     setState(() {});
//   }
//
//   _fetchFriendsList() async {
//     final token = _accessToken?.toJson()['token'] as String?;
//     if (token != null) {
//       final graphResponse = await http.get(Uri.parse(
//           'https://graph.facebook.com/v12.0/me/friends?access_token=$token'));
//       final result = json.decode(graphResponse.body);
//       setState(() {
//         _friendsList = result['data'];
//       });
//     }
//   }
//
//   _fetchPhotosList() async {
//     final token = _accessToken?.toJson()['token'] as String?;
//     if (token != null) {
//       final graphResponse = await http.get(Uri.parse(
//           'https://graph.facebook.com/v12.0/me/photos?access_token=$token'));
//       final result = json.decode(graphResponse.body);
//       setState(() {
//         _photosList = result['data'];
//       });
//     }
//   }
//
//   _fetchPostsList() async {
//     final token = _accessToken?.toJson()['token'] as String?;
//     if (token != null) {
//       final graphResponse = await http.get(Uri.parse(
//           'https://graph.facebook.com/v12.0/me/posts?access_token=$token'));
//       final result = json.decode(graphResponse.body);
//       setState(() {
//         _postsList = result['data'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: _checking
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (_userData != null) ...[
//                 Text('Name: ${_userData!['name']}'),
//                 Text('Email: ${_userData!['email']}'),
//                 Image.network(_userData!['picture']['data']['url']),
//                 SizedBox(height: 20),
//                 Text('Friends List:'),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _friendsList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_friendsList[index]['name']),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Text('Photos:'),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _photosList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text('Photo ${index + 1}'),
//                       subtitle: Text(_photosList[index]['id']),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Text('Posts:'),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _postsList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_postsList[index]['message'] ?? 'No message'),
//                       subtitle: Text(_postsList[index]['created_time']),
//                     );
//                   },
//                 ),
//               ],
//               SizedBox(height: 20),
//               CupertinoButton(
//                 color: Colors.blue,
//                 child: Text(
//                   _userData != null ? 'LOGOUT' : 'LOGIN',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 onPressed: _userData != null ? _logout : _login,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }