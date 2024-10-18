import 'package:bmi_calculator/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool male = false;
  bool female = false;
  bool click = false;
  String result = "";
  String gendername = "";
  double male_height = 110;
  double female_height = 110;
  double male_width = 100;
  double female_width = 100;
  var weight = 0;
  var height = 0;
  var age = 0;
  int cal_data = 0;

  Color _bgcolor_ = Colors.white;

  void _calculateBMI() {
    var weight = double.tryParse(_weightController.text);
    var height = double.tryParse(_heightController.text);
    var age = double.tryParse(_ageController.text);

    if (weight != null &&
        height != null &&
        height > 0 &&
        weight > 0 &&
        age != null &&
        age > 0 &&
        click) {
      var bmi = weight / (height / 100 * height / 100);
      // bmi = bmi.round() as double;
      var temp_bmi = bmi;
      if (temp_bmi > 40) temp_bmi = 40;
      setState(() {
        if (temp_bmi < 18.5) {
          result = 'Underweight';
        } else if (temp_bmi >= 18.5 && bmi < 25) {
          result = 'Good';
        } else if (temp_bmi >= 25 && bmi < 30) {
          result = 'Overweight';
        } else if (temp_bmi >= 30 && bmi < 35) {
          result = 'Class I Obesity';
        } else if (temp_bmi >= 35 && bmi < 40) {
          result = 'Class II Obesity';
        } else {
          result = 'Class III Obesity';
        }
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Your BMI',
            style: TextStyle(
                fontSize: 37, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpeedometerChart(
                dimension: 250,
                value: temp_bmi,
                valueWidget: Text(
                  bmi.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 24),
                ),
                hasIconPointer: true, // Use default pointer
                pointerColor: Colors.black,
                graphColor: const [Colors.red, Colors.green, Colors.red],
                minValue: 0,
                maxValue: 40,
                minWidget: const Text("Min:0"),
                maxWidget: const Text("Max:40"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\"$result\"",
                style: const TextStyle(
                    fontSize: 37,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Gender : $gendername",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Age : $age",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Weight : $weight kg",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Height : $height cm",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                  ),
                  onPressed: suggestion,
                  child: const Text(
                    "Suggestion",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // Text('Your BMI is ${bmi.toStringAsFixed(2)}'),
    } else {
      // Handle invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please enter valid weight or height or Age or Gender')),
      );
    }
  }

  void suggestion() {
    if (gendername == 'Male') {
      switch (result) {
        case 'Underweight':
          cal_data = 1;
          break;
        case 'Good':
          cal_data = 3;
          break;
        case 'Overweight':
          cal_data = 5;
          break;
        case 'Class I Obesity':
          cal_data = 7;
          break;
        case 'Class II Obesity':
          cal_data = 9;
          break;
        default:
          cal_data = 11;
      }
    } else {
      switch (result) {
        case 'Underweight':
          cal_data = 0;
          break;
        case 'Good':
          cal_data = 2;
          break;
        case 'Overweight':
          cal_data = 4;
          break;
        case 'Class I Obesity':
          cal_data = 6;
          break;
        case 'Class II Obesity':
          cal_data = 8;
          break;
        default:
          cal_data = 10;
      }
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "Recommendation",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gendername,
                    style: const TextStyle(
                        fontSize: 27,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Calories intake : ${data_calories[cal_data]}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Strength Training : ${data_strength[cal_data]}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Body Exercise : ${data_body[cal_data]}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Duration :${data_dura[cal_data]}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Frequency : ${data_fre[cal_data]}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  void gender(int n) {
    click = true;
    setState(() {
      if (n == 0) {
        male = true;
        female = false;
        male_height = 175;
        male_width = 160;
        female_height = 110;
        female_width = 100;
        gendername = "Male";
        _bgcolor_ = Colors.blue.shade100;
      } else {
        male = false;
        female = true;
        male_height = 110;
        male_width = 100;
        female_height = 175;
        female_width = 160;
        gendername = "Female";
        _bgcolor_ = Colors.pink.shade100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: _bgcolor_,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Choose your Gender ",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      gender(0);
                    },
                    child: Container(
                      width: male_width,
                      height: male_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "images/male.png",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      gender(1);
                    },
                    child: Container(
                      width: female_width,
                      height: female_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "images/female.png",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Allows only digits
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Allows only digits
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Allows only digits
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: _calculateBMI,
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
