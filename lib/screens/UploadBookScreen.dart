import 'package:book_store/models/Books.dart';
import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadBookScreen extends StatefulWidget {
  static const String ROUTE_NAME = "UploadBookScreen";

  @override
  _UploadBookScreenState createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  final _form = GlobalKey<FormState>();
  final _bookImageController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _bookUrlController = TextEditingController();
  final _bookDescriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  BooksProvider _booksProvider;
  String _dropdownValue = 'Horror Novel';
  final _spinnerItems = [
    'Horror Novel',
    'Arabic Novels',
    'Foreign Novels',
    'Translated Novels',
    'Romantic Novels',
    'Islamic Books'
  ];

  @override
  void dispose() {
    _bookImageController.dispose();
    _bookNameController.dispose();
    _bookUrlController.dispose();
    _bookDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _booksProvider = Provider.of<BooksProvider>(context, listen: false);
    _bookDescriptionController.text = "asassdddddddddddddddddddddddddddds";
    _bookImageController.text = "http.png";
    _bookUrlController.text = "http.pdf";
    _bookNameController.text = "asdadasd";
    super.initState();
  }

  Future<void> saveBook() async {
    if (!_form.currentState.validate() || _booksProvider == null) return;

    try{
      await _booksProvider
          .uploadNewBook(
          Books(
              "5454",
              "hell",
              "54545",
              0,
              "4",
              _bookUrlController.text,
              _bookImageController.text,
              _bookDescriptionController.text),
          _dropdownValue);
      showSnackBar(true);
    }catch(error) {
      showSnackBar(false);
    }
  }

  Future showSnackBar(bool isSuccess) async {
    await _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 450),
        content: Text(
          isSuccess? "upload success..":"upload failed.." ,
          textAlign: TextAlign.center,
        ))).closed.then((value) {
          if(isSuccess) Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Upload Book"), actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: saveBook,
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<BooksProvider>(
          builder: (_, provider, __) => provider.isLoading? Center(child: CircularProgressIndicator()):
          Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  controller: _bookNameController,
                  decoration: InputDecoration(labelText: "Book Name"),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) return "Please Add Book Name.";
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Text(
                    "Category: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: _dropdownValue,
                    items: _spinnerItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _dropdownValue = val;
                      });
                    },
                  ),
                ]),
                TextFormField(
                  controller: _bookUrlController,
                  decoration: InputDecoration(labelText: "Book URL"),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty)
                      return "Please Add Book url.";
                    else if (!val.startsWith("http") || !val.endsWith(".pdf"))
                      return "Please add an invalid url";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bookImageController,
                  decoration: InputDecoration(labelText: "Book Cover URL"),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty ||
                        (!val.startsWith('http')) ||
                        (!val.endsWith('.jpg')) &&
                            (!val.endsWith('jpeg')) &&
                            (!val.endsWith('png')))
                      return "Please add an invalid image url ex. jpg, jpeg, png";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bookDescriptionController,
                  decoration: InputDecoration(labelText: "Book Description"),
                  textInputAction: TextInputAction.done,
                  validator: (val) {
                    if (val.isEmpty)
                      return "Please Add Book Description.";
                    else if (val.length < 10)
                      return "Please add description bigger than 10 characters";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
