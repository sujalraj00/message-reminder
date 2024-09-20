// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import '../fb.dart';
// import '../res/consts/t_colors.dart';
// import '../res/helper/helper_function.dart';
//
// class TDrawer extends StatefulWidget {
//   const TDrawer({super.key});
//
//   @override
//   State<TDrawer> createState() => _TDrawerState();
// }
//
// class _TDrawerState extends State<TDrawer> {
//   Map<String, dynamic>? _userData;
//   //AccessToken? _accessToken;
//   late Future<void> _initFuture;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _initFuture = _checkIfisLoggedIn();
//   // }
//   //
//   // Future<void> _checkIfisLoggedIn() async {
//   //   final accessToken = await FacebookAuth.instance.accessToken;
//   //   if (accessToken != null) {
//   //     final userData = await FacebookAuth.instance.getUserData();
//   //     _accessToken = accessToken;
//   //     setState(() {
//   //       _userData = userData;
//   //     });
//   //   } else {
//   //     _login();
//   //   }
//   // }
//   //
//   // Future<void> _login() async {
//   //   final LoginResult result = await FacebookAuth.instance.login();
//   //   if (result.status == LoginStatus.success) {
//   //     _accessToken = result.accessToken;
//   //     final userData = await FacebookAuth.instance.getUserData();
//   //     setState(() {
//   //       _userData = userData;
//   //     });
//   //   } else {
//   //     print(result.status);
//   //     print(result.message);
//   //   }
//   // }
//   //
//   // Future<void> _logout() async {
//   //   await FacebookAuth.instance.logOut();
//   //   setState(() {
//   //     _accessToken = null;
//   //     _userData = null;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: FutureBuilder(
//           future: _initFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DrawerHeader(
//                       decoration: const BoxDecoration(),
//                       child: Column(
//                         children: [
//                           _userData != null
//                               ? CircleAvatar(
//                             radius: 50,
//                             backgroundImage: NetworkImage(
//                               _userData!['picture']['data']['url'],
//                             ),
//                           )
//                               : CircleAvatar(
//                             radius: 50,
//                             backgroundColor:
//                             THelperFunctions.isDarkMode(context)
//                                 ? TColors.black
//                                 : TColors.white,
//                           ),
//                         ],
//                       ),
//                     ),
//                     _buildTextButton(
//                       context,
//                       'Connect Facebook',
//                           () {
//                         const FbLogin();
//                         Navigator.pop(context);
//                       },
//                     ),
//                     _buildTextButton(
//                       context,
//                       'Connect Instagram',
//                           () {},
//                     ),
//                     _buildTextButton(
//                       context,
//                       'Privacy Policy',
//                           () {},
//                     ),
//                     _buildTextButton(
//                       context,
//                       'Help',
//                           () {},
//                     ),
//                     _buildTextButton(
//                       context,
//                       'Contact Us',
//                           () {},
//                     ),
//                   ],
//                 ),
//                 TextButton.icon(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.grey,
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                   onPressed: _userData != null ? _logout : _login,
//                   icon: Text(
//                     _userData != null ? 'LOGOUT' : 'LOGIN',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   label: const Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 )
//
//
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextButton(
//       BuildContext context, String text, VoidCallback onPressed) {
//     return TextButton(
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.bodyLarge,
//       ),
//     );
//   }
// }
