import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz_question.dart';

import 'models/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _journals = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ans1Controller = TextEditingController();
  final TextEditingController _ans2Controller = TextEditingController();
  final TextEditingController _ans3Controller = TextEditingController();
  final TextEditingController _ans4Controller = TextEditingController();
  final TextEditingController _diffController = TextEditingController();

  bool _isLoading = true;

  Future<void> _addItem() async {
    await SQLHelper.createItem(
      _titleController.text,
      _ans1Controller.text,
      _ans2Controller.text,
      _ans3Controller.text,
      _ans4Controller.text,
      _diffController.text,
    );

    _refreshJournals();

    print("we have ${_journals.length} task");
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);

    _refreshJournals();

    print("Item $id deleted successfully");

    print("we have ${_journals.length} task");
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
      id,
      _titleController.text,
      _ans1Controller.text,
      _ans2Controller.text,
      _ans3Controller.text,
      _ans4Controller.text,
      _diffController.text,
    );

    _refreshJournals();

    print("Item $id updated successfully");
  }

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;

      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshJournals();
    print("we have ${_journals.length} task");
  }

  void _showForm(int? id) {
    if (id != null) {
      final existingJournal = _journals.firstWhere(
        (element) => element['id'] == id,
      );
      _titleController.text = existingJournal['title'];
      _ans1Controller.text = existingJournal['ans1'];
      _ans2Controller.text = existingJournal['ans2'];
      _ans3Controller.text = existingJournal['ans3'];
      _ans4Controller.text = existingJournal['ans4'];
      _diffController.text = existingJournal['diff'];
    }

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter Title';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('question title'),
                  prefix: Icon(Icons.abc_outlined),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ans1Controller,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter answer 1';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Correct Answer',
                  ),
                  prefix: Icon(
                    Icons.abc_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ans2Controller,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter answer 2';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Answer 2',
                  ),
                  prefix: Icon(
                    Icons.abc_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ans3Controller,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter answer 3';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Answer 3',
                  ),
                  prefix: Icon(
                    Icons.abc_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ans4Controller,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter answer 4';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Answer 4',
                  ),
                  prefix: Icon(
                    Icons.abc_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _diffController,
                validator: (dynamic value) {
                  if (value.toString().isEmpty) {
                    return 'Enter difficulty';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Difficulty',
                  ),
                  prefix: Icon(
                    Icons.abc_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addItem();
                  }
                  if (id != null) {
                    await _updateItem(id);
                  }

                  _titleController.text = '';
                  _ans1Controller.text = '';
                  _ans2Controller.text = '';
                  _ans3Controller.text = '';
                  _ans4Controller.text = '';
                  _diffController.text = '';

                  Navigator.of(context).pop();
                },
                child: id == null
                    ? const Text("Create New")
                    : const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Questions"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.blue[800],
          margin: const EdgeInsets.all(15),
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.top,
            leading: Text(
              _journals[index]['diff'],
            ),
            title: Text(
              _journals[index]['title'],
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                Text(
                  _journals[index]['ans1'],
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
                Text(
                  _journals[index]['ans2'],
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _journals[index]['ans3'],
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _journals[index]['ans4'],
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _showForm(_journals[index]['id']),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteItem(_journals[index]['id']),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: _journals.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
