part of transnode.components;

@NgComponent(
    selector: 'contact',
    templateUrl: 'partials/contacts/form_customer.html',
    applyAuthorStyles: true,
    publishAs: 'ctrl_contact'
)
class ContactComponent {
  @NgTwoWay("contacts")
  List<Contact> contacts;

  ContactComponent() {
    this.contacts = [new Contact()];
  }

  void addItem() {
    contacts.add(new Contact());
  }

  void deleteItem(Contact item) {
    contacts.remove(item);
  }
}
