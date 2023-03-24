import 'package:mobx/mobx.dart';

import 'contact.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>.of(
     [
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

     ]
  );

  @action
  void addContact(Contact contact) {
    contacts.add(contact);
  }
}
