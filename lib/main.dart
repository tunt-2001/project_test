import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Contact> contacts = [
    Contact(
      name: 'John Doe',
      phone: '5556661234',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'Jane Doe',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'f',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'e',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),Contact(
      name: 'd',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),Contact(
      name: 'J',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),Contact(
      name: 'b',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),Contact(
      name: 'a',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'admin',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'ad',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),Contact(
      name: 'pro',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),
    Contact(
      name: 'do',
      phone: '5556665678',
      avatar: 'https://ap.poly.edu.vn/images/logo.png',
    ),


  ];
  String _searchQuery = '';
  List<Contact> _searchResult = [];

  // Method to filter the data based on the search query
  void _filterData(String query) {
    List<Contact> result = [];
    contacts.forEach((item) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        result.add(item);
      }
    });
    setState(() {
      _searchResult = result;
    });
  }




  @override
  void initState() {
    super.initState();
    _filterData(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        // actions: [
        //   // Navigate to the Search Screen
        //   IconButton(
        //       onPressed: () => Navigator.of(context)
        //           .push(MaterialPageRoute(builder: (_) => const SearchPage())),
        //       icon: const Icon(Icons.search))
        // ],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context,
                  delegate: ContactSearchDelegate(contacts));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(contact.avatar),
                backgroundColor: Colors.white,
              ),
              onTap: () {
                // close(context, contact);
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(contact),),);
              },
              title: Text(
                // _searchResult[index].name,
                contact.name,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                // _searchResult[index].phone,
                contact.phone,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            secondaryActions: [
              IconSlideAction(
                caption: 'Edit',
                color: Colors.yellow,
                icon: Icons.edit,
                onTap: () async {
                  final updatedContact = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        contacts: contact,
                      ),
                    ),
                  );
                  if (updatedContact != null) {
                    setState(() {
                      contacts[index] = updatedContact;
                    });
                  }
                },
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondScreen(),
            ),
          );
          if (newContact != null) {
            setState(() {
              contacts.add(newContact);
            });
          }
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}


class ContactSearchDelegate extends SearchDelegate<Contact> {
  final List<Contact> contacts;

  ContactSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
          Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var contact = results[index];
        return ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.phone),
          onTap: () {
            close(context, contact);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final contact = suggestions[index];
        return ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.phone),
          onTap: () {
            query = contact.name;
            close(context, contact);
          },
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Contact contacts;
  DetailScreen(this.contacts);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contacts.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(contacts.avatar),
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 16),
            Text('Name: ${contacts.name}'),
            Text('Phone: ${contacts.phone}'),
          ],
        ),
      ),
    );
  }
}



class Contact {
  final String name;
  final String phone;
  final String avatar;

  Contact({required this.name, required this.phone, required this.avatar});
}
