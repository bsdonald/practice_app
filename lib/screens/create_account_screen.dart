import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';
import '../providers/accounts.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/add_account';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  var _editedAccount = Account(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    imageUrl: '',
  );

  final _form = GlobalKey<FormState>();

  var _initValues = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'imageUrl': '',
  };

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') && !_imageUrlController.text.endsWith('.jpg') && !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Accounts>(context, listen: false).addAccount(_editedAccount);
    Navigator.of(context).pushReplacementNamed('/Character_List_Screen');
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create/Edit Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: deviceSize.width * 0.45,
                    child: TextFormField(
                      initialValue: _initValues['firstName'],
                      decoration: InputDecoration(labelText: 'First Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your first name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          firstName: value,
                          lastName: _editedAccount.lastName,
                          email: _editedAccount.email,
                          imageUrl: _editedAccount.imageUrl,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.45,
                    child: TextFormField(
                      initialValue: _initValues['lastName'],
                      decoration: InputDecoration(labelText: 'Last Name'),
                focusNode: _lastNameFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          firstName: _editedAccount.firstName,
                          lastName: value,
                          email: _editedAccount.email,
                          imageUrl: _editedAccount.imageUrl,
                        );
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                initialValue: _initValues['email'],
                decoration: InputDecoration(labelText: 'email'),
                focusNode: _emailFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedAccount = Account(
                    id: _editedAccount.id,
                    firstName: _editedAccount.firstName,
                    lastName: _editedAccount.lastName,
                    email: value,
                    imageUrl: _editedAccount.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text('Enter a URL'),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') && !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          firstName: _editedAccount.firstName,
                          lastName: _editedAccount.lastName,
                          email: _editedAccount.email,
                          imageUrl: value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
