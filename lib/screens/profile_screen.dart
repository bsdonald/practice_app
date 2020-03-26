// import 'package:flutter/material.dart';
// import 'package:practice_app/providers/account.dart';
// import 'package:provider/provider.dart';

// import '../widgets/app_drawer.dart';
// import '../providers/account.dart';
// class ProfileScreen extends StatefulWidget {
//   static const routeName = '/profile-screen';

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _form = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final accountsData = Provider.of<Account>(
//       context);
//       final accounts = accountsData.items;
//     return Scaffold(
//       drawer: AppDrawer(),
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,

//         title: Text('Profile'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _form,
//           child: SingleChildScrollView(
//             child: Row(
//               children: <Widget>[
//                 Container( child: Text (accounts.name),
//               // height: 300,
//               // width: double.infinity,
//               // child: Image.network(
//               //   loadedAccount.imageUrl,
//               //   fit: BoxFit.scaleDown,
//               // ),
//             ),
//             Container(
//               child: Text ('Hello World'),
//             ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
