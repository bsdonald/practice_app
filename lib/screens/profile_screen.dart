import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/accounts_list.dart';
import '../providers/accounts.dart';
class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of(context).fetchAndSetProducts();
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Accounts>(context).fetchAndSetAccounts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    // final accountsData = Provider.of<Account>(
    //   context);
    //   final accounts = accountsData.items;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,

        title: Text('Profile'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit), onPressed: (){
            Navigator.of(context).pushNamed('/add_account');
          })
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AccountList(),
    );
  }
}
