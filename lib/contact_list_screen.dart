import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final List<Map<String, String>> _contacts = [];

  // Variable to store the index of the contact to delete
  // int? _contactToDeleteIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameTEController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _numberTEController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                _addNameNumber();
              },
              child: const Text('Add'),
            ),
            const SizedBox(
              height: 16,
            ),
            _addDetails(),
          ],
        ),
      ),
    );
  }

  void _addNameNumber() {
    final String name = _nameTEController.text.trim();
    final String number = _numberTEController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {});
      _contacts.add({'name': name, 'number': number});
      _nameTEController.clear();
      _numberTEController.clear();
    }
  }

  Widget _addDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _contacts.length,
          reverse: true,
          itemBuilder: (context, index) {
            final contact = _contacts[index];
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(contact['name'] ?? 'No Name'),
              subtitle: Text(contact['number'] ?? 'No Number'),
              trailing: const Icon(Icons.call),
              onLongPress: () =>
                  _showDeleteDialog(index), // Pass the index here
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _numberTEController.dispose();
    super.dispose();
  }
}
