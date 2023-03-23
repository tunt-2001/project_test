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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        // actions: [
        //   IconButton(onPressed: () => setState(() {
        //
        //   }), icon: Icon(Icons.search,size: 30,),
        //   )
        // ],
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search))
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
              title: Text(
                contact.name,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
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
                        contact: contact,
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

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

class Contact {
  final String name;
  final String phone;
  final String avatar;

  Contact({required this.name, required this.phone, required this.avatar});
}
