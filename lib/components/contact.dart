part of transnode.components;

@NgComponent(
    selector: 'contact',
    templateUrl: 'partials/contacts/form_customer.html',
    applyAuthorStyles: true,
    publishAs: 'ctrl_contact'
)
class ContactComponent {
  @NgTwoWay("contacts")
  List<Location> contacts;

  ContactComponent() {
    this.contacts = [new Location()];
  }

  void addItem() {
    contacts.add(new Location());
  }

  void deleteItem(Location item) {
    contacts.remove(item);
  }
}
