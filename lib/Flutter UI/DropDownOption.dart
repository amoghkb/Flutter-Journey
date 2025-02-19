import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dropdownoption extends StatefulWidget {
  const Dropdownoption({super.key});

  @override
  State<Dropdownoption> createState() => _DropdownoptionState();
}

class _DropdownoptionState extends State<Dropdownoption> {
  List<String> indianStates = [
    "Not Selected",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];
  String selectedState = "Not Selected"; // Correct initialization

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dropdown Example"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              width:
                  MediaQuery.of(context).size.width * 0.8, // Responsive width
              decoration: BoxDecoration(
                color: Colors.deepPurple[100], // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                border:
                    Border.all(color: Colors.deepPurple, width: 2), // Border
              ),
              child: DropdownButton<String>(
                menuMaxHeight: 400, // Limits dropdown height
                hint: const Text("Select State"),
                elevation: 11,
                alignment: Alignment.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                borderRadius: BorderRadius.circular(10),
                isExpanded: true, // Ensures full width
                underline: Container(), // Removes default underline
                dropdownColor:
                    Colors.deepPurple[50], // Dropdown background color
                icon: const Icon(CupertinoIcons.location_solid,
                    color: Colors.deepPurple),
                value: selectedState, // Corrected value
                items: indianStates.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
