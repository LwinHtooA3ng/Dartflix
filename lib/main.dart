import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dotted_border/dotted_border.dart';

void main() => runApp(const dartflix());

class dartflix extends StatelessWidget {
  const dartflix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          // errorBorder: OutlineInputBorder(),
          // focusedErrorBorder: OutlineInputBorder(),
        ),
      ),
      home: const shopPage(),
    );
  }
}

class shopPage extends StatefulWidget {
  const shopPage({Key? key}) : super(key: key);

  @override
  State<shopPage> createState() => _shopPageState();
}

class _shopPageState extends State<shopPage> {
  var cost;

  String? message = "";

  String? owner = "";

  final _formKey = GlobalKey<FormState>();

  bool _submitted = false;

  bool _correctState = false;

  TextEditingController _name = TextEditingController();

  List<String> profile = ["1", "2", "3", "4", "5"];
  dynamic selectedProfile = "1";

  List<String> plan = ["HD", "FHD", "Streams + Download"];
  String? selectedPlan = "HD";

  // for 1 profile
  // HD = 5000mmk
  // FHD = 8000mmk
  // Streams + Download = 10000mmk

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Dartflix"),
            elevation: 0,
            backgroundColor: Colors.indigoAccent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _name,
                          style: TextStyle(color: Colors.grey[800]),
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.indigoAccent,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Name can't empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              icon: const Icon(
                                Icons.person_rounded,
                                color: Colors.grey,
                                size: 35,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Text(
                                "Number of profile",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              icon: const Icon(
                                Icons.mobile_screen_share,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ),
                            value: selectedProfile,
                            items: profile
                                .map((item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)))
                                .toList(),
                            onChanged: (item) {
                              setState(() {
                                selectedProfile = item.toString();
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Text(
                                "Plan",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              icon: const Icon(
                                Icons.movie_creation_outlined,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ),
                            value: selectedPlan,
                            items: plan
                                .map((item) => DropdownMenuItem(
                                    value: item, child: Text(item)))
                                .toList(),
                            onChanged: (item) {
                              setState(() {
                                selectedPlan = item.toString();
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            final nameValidate =
                                _formKey.currentState!.validate();

                            setState(() {
                              _submitted = true;
                            });

                            if (nameValidate) {
                              setState(() {
                                _correctState = true;
                              });
                              if (selectedPlan == "HD") {
                                cost = int.parse(selectedProfile) * 5000;
                              } else if (selectedPlan == "FHD") {
                                cost = int.parse(selectedProfile) * 8000;
                              } else if (selectedPlan == "Streams + Download") {
                                cost = int.parse(selectedProfile) * 10000;
                              }
                              setState(() {
                                owner = _name.text;
                                message =
                                    "$cost mmk for $selectedProfile profile with $selectedPlan plan.";
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigoAccent),
                          child: const Text("Buy"),
                        ),
                      ],
                    ),
                  ),
                  const DottedLine(
                    dashLength: 10,
                    dashGapLength: 10,
                    dashColor: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (_correctState && _name.text.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: DottedBorder(
                              color: Colors.grey,
                              dashPattern: const [8, 4],
                              strokeWidth: 2,
                              strokeCap: StrokeCap.round,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 100,
                                width: 300,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Owner :   ",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "$owner",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Cost    :   ",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "$message",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      ))
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
