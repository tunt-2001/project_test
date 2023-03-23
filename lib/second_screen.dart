import 'package:flutter/material.dart';
import 'package:project_test/main.dart';

class SecondScreen extends StatefulWidget {
  final Contact? contact;

  SecondScreen({this.contact});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _avatarController = TextEditingController();
  late String _avatarUrl;



  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _phoneController.text = widget.contact!.phone;
      _avatarController.text = widget.contact!.avatar;
      _avatarUrl = widget.contact!.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                    RegExp regExp = new RegExp(pattern);
                    if (value?.length == 0) {
                      return 'Vui lòng nhập số điện thoại';
                    } else if (!regExp.hasMatch(value!)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _avatarController,
                  decoration: InputDecoration(
                    labelText: 'Avatar (link)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    setState(() {
                      _avatarUrl = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an avatar link';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final contact = Contact(
              name: _nameController.text,
              phone: _phoneController.text,
              avatar: _avatarUrl,
            );
            Navigator.pop(context, contact);
          }
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),

    );
  }
}


