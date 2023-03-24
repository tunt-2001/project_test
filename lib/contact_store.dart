import 'package:mobx/mobx.dart';

import 'main.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>();

  @action
  void addContact(Contact contact) {
    contacts.add(contact);
  }
}
