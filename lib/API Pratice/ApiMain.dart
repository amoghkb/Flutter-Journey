import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ApiModel.dart';

/// put this page in the main to know adout the Rest API CRUD
class Apimain extends StatefulWidget {
  const Apimain({super.key});

  @override
  State<Apimain> createState() => _ApimainState();
}

class _ApimainState extends State<Apimain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final url = "https://retoolapi.dev/LHX8zq/data";

  List<ApiModel> Apidata = [];

  /// Future method to get the details from api with http.get
  Future getDetails() async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        setState(() {
          Apidata = data.map((e) => ApiModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  final NameController = TextEditingController();
  final CompanyController = TextEditingController();
  final EmailController = TextEditingController();
  final AddressController = TextEditingController();

  /// Future method to get the details from api with http.post
  Future postdetails() async {
    try {
      final res = await http.post(Uri.parse("$url"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Name": NameController.text,
            "Company": CompanyController.text,
            "Email": EmailController.text,
            "Address": AddressController.text,
          }));
      if (res.statusCode == 200 || res.statusCode == 201) {
        setState(() {
          Apidata.add(ApiModel.fromJson(jsonDecode(res.body)));
        });
        getDetails();
        NameController.clear();
        CompanyController.clear();
        EmailController.clear();
        AddressController.clear();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      print(e);
    }
  }

  ///Future method to delete the details from api with http.delete

  Future deletedetails(int id) async {
    try {
      final res = await http.delete(Uri.parse("$url/$id"));
      if (res.statusCode == 200) {
        setState(() {
          Apidata.removeWhere((element) => element.id == id);
        });
        print('element element deleted');
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  final UpdateNameController = TextEditingController();
  final UpdateCompanyController = TextEditingController();
  final UpdateEmailController = TextEditingController();
  final UpdateAddressController = TextEditingController();

  /// Future method to update the details from api with http.put
  Future updatedetails(int id) async {
    final res = await http.put(Uri.parse("$url/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Name": UpdateNameController.text,
          "Company": UpdateCompanyController.text,
          "Email": UpdateEmailController.text,
          "Address": UpdateAddressController.text,
        }));
    if (res.statusCode == 200) {
      print("updated");
      getDetails();
    }
  }

  int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API TEST"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                highlightColor: Colors.teal,
                color: Colors.black,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Add Details"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: NameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: CompanyController,
                                  decoration: InputDecoration(
                                    hintText: "Company",
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: EmailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: AddressController,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                  )),
                            )
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                postdetails();
                                Navigator.pop(context);
                              },
                              child: Text("Add")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(CupertinoIcons.plus)),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Details"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: UpdateNameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: UpdateCompanyController,
                              decoration: InputDecoration(
                                hintText: "Company",
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: UpdateEmailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: UpdateAddressController,
                              decoration: InputDecoration(
                                hintText: "Address",
                              )),
                        )
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            updatedetails(Apidata[index].id);
                            Navigator.pop(context);
                          },
                          child: Text("Add")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: Container(
                height: 200,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Name : ${Apidata[index].Name}',
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                deletedetails(Apidata[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Company : ${Apidata[index].Company}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Email : ${Apidata[index].Email}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Address : ${Apidata[index].Address}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: Apidata.length,
      ),
    );
  }
}
