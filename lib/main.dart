import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _genderValue;
  String _formulaType;
  int selectedRadio;
  int selectedRadioTile;
  int age, height, weight;
  double total = 0;
  double total2 = 0;
  int bmr = 0;
  int calories = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  void _calculate() {
    setState(() {
      age = int.parse(_ageController.text);
      weight = int.parse(_weightController.text);
      height = int.parse(_heightController.text);

      if (_formulaType == "1") {
        if (_genderValue == "Male") {
          total = ((10 * weight) + (6.25 * height) - (5 * age) + 5);
        } else {
          total = ((10 * weight) + (6.25 * height) - (5 * age) - 161);
        }
      } else {
        if (_genderValue == "Male") {
          total = (66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age));
        } else {
          total = (655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age));
        }
      }

      if (selectedRadioTile == 1) {
        total2 = total * 1.2;
        total2.round();
      } else if (selectedRadioTile == 2) {
        total2 = total * 1.375;
        total2.round();
      } else if (selectedRadioTile == 3) {
        total2 = total * 1.55;
        total2.round();
      } else if (selectedRadioTile == 4) {
        total2 = total * 1.725;
        total2.round();
      } else {
        total2 = total * 1.9;
        total2.round();
      }
      bmr = total.round();
      calories = total2.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BMR Calculator',
        ),
        actions: <Widget>[
          // action button
          Icon(
            Icons.clear,
          ),
        ],
        backgroundColor: Colors.indigo[500],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 160,
                width: 90,
                child: Image.asset('asset/bmr_logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    padding: EdgeInsets.fromLTRB(10.0, 3.0, 3.0, 3.0),
                    child: DropdownButton<String>(
                      underline: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))),
                      ),
                      hint: Text(
                        "BMR Method",
                      ),
                      items: [
                        DropdownMenuItem<String>(
                            child: Text('Mifflin - St Jeor (default)'),
                            value: "1"),
                        DropdownMenuItem<String>(
                            child: Text('Harris - Benedict'), value: "2"),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          _formulaType = value;
                        });
                      },
                      value: _formulaType,
                    ),
                  ),
                  Container(
                    width: 123.0,
                    height: 50.0,
                    margin: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 3.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                    child: DropdownButton<String>(
                      hint: Text(
                        "Gender",
                      ),
                      underline: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                            child: Text('Male'), value: 'Male'),
                        DropdownMenuItem<String>(
                            child: Text('Female'), value: 'Female'),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          _genderValue = value;
                        });
                      },
                      value: _genderValue,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 25, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _ageController,
                  decoration: InputDecoration(
                      hintText: "years",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      labelText: "AGE"),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _weightController,
                  decoration: InputDecoration(
                    hintText: "kg",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "WEIGHT",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _heightController,
                  decoration: InputDecoration(
                    hintText: "cm",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "HEIGHT",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 20.0, 80.0, 0.0),
                child: Text(
                  'Please select your activity level: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text(
                  "Sedentary",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "Little or no exercise",
                ),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text(
                  "Lightly Active",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("Light exercise or sports 1-3 days per week"),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
              ),
              RadioListTile(
                value: 3,
                groupValue: selectedRadioTile,
                title: Text(
                  "Moderately Active",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("Moderate exercise or sports 4-5 days per week"),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
              ),
              RadioListTile(
                value: 4,
                groupValue: selectedRadioTile,
                title: Text(
                  "Active",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("Hard exercise or sports 6-7 days per week"),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
              ),
              RadioListTile(
                value: 5,
                groupValue: selectedRadioTile,
                title: Text(
                  "Super Active",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle:
                    Text("Very hard exercise or sports and a physical job"),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: RaisedButton(
                  onPressed: _calculate,
                  textColor: Colors.black,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF90A4AE),
                            Color(0xFF90A4AE),
                            Color(0xFF90A4AE)
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(14.0),
                      child: Text('Calculate')),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 280.0, 0.0),
                child: Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                width: 300,
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF7E57C2),
                      Color(0xFF7E57C2),
                      Color(0xFF7E57C2),
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 30.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFD1C4E9),
                            Color(0xFFD1C4E9),
                            Color(0xFFD1C4E9),
                          ],
                        ),
                      ),
                      child: Text("Your BMR is $bmr"),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFD1C4E9),
                            Color(0xFFD1C4E9),
                            Color(0xFFD1C4E9),
                          ],
                        ),
                      ),
                      child: Text("Maintenance calories per day is $calories"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  10.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
