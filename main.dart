import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SignInScreen(),
    SignUpScreen(),
    SimpleCalculator(), // Using SimpleCalculator widget instead of CalculatorScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEDAR APP'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              title: Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Sign In ',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the calculator screen
                final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                if (homeScreenState != null) {
                  homeScreenState._onItemTapped(2);
                }
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to the sign up screen
                final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                if (homeScreenState != null) {
                  homeScreenState._onItemTapped(1); // Assuming 1 is the index for SignUpScreen
                }
              },
              child: Text('Don\'t have an account?   Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Sign Up ',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),

            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the calculator screen
                final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                if (homeScreenState != null) {
                  homeScreenState._onItemTapped(2);
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Calculation();
  }
}

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  List<dynamic> inputList = [0];
  String output = '0';

  void _handleClear() {
    setState(() {
      inputList = [0];
      output = '0';
    });
  }

  void _handlePress(String input) {
    setState(() {
      if (_isOperator(input)) {
        if (inputList.last is int) {
          inputList.add(input);
          output += input;
        }
      } else if (input == '=') {
        while (inputList.length > 2) {
          int firstNumber = inputList.removeAt(0) as int;
          String operator = inputList.removeAt(0);
          int secondNumber = inputList.removeAt(0) as int;
          int partialResult = 0;

          if (operator == '+') {
            partialResult = firstNumber + secondNumber;
          } else if (operator == '-') {
            partialResult = firstNumber - secondNumber;
          } else if (operator == '*') {
            partialResult = firstNumber * secondNumber;
          } else if (operator == '/') {
            partialResult = firstNumber ~/ secondNumber;
            // Protect against division by zero
            if (secondNumber == 0) {
              partialResult = firstNumber;
            }
          }

          inputList.insert(0, partialResult);
        }

        output = '${inputList[0]}';
      } else {
        int? inputNumber = int.tryParse(input);
        if (inputNumber != null) {
          if (inputList.last is int && !_isOperator(output[output.length - 1])) {
            int lastNumber = (inputList.last as int);
            lastNumber = lastNumber * 10 + inputNumber;
            inputList.last = lastNumber;

            output = output.substring(0, output.length - 1) + lastNumber.toString();
          } else {
            inputList.add(inputNumber);
            output += input;
          }
        }
      }
    });
  }

  bool _isOperator(String input) {
    if (input == "+" || input == "-" || input == "*" || input == "/") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CALCULATOR")),
      body: Container(
        padding: EdgeInsets.all(3.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(3.0),
              alignment: Alignment.centerRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  for (var i = 0; i <= 9; i++)
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                      ),
                      child: Text("$i", style: TextStyle(fontSize: 20, color: Colors.black)),
                      onPressed: () => _handlePress("$i"),
                    ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                    ),
                    child: Text("C", style: TextStyle(fontSize: 20, color: Colors.green)),
                    onPressed: _handleClear,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                    ),
                    child: Text("+", style: TextStyle(fontSize: 20, color: Colors.green)),
                    onPressed: () => _handlePress("+"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                    ),
                    child: Text("-", style: TextStyle(fontSize: 25, color: Colors.green)),
                    onPressed: () => _handlePress("-"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                    ),
                    child: Text("*", style: TextStyle(fontSize: 20, color: Colors.green)),
                    onPressed: () => _handlePress("*"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                    ),
                    child: Text("/", style: TextStyle(fontSize: 20, color: Colors.lightGreen)),
                    onPressed: () => _handlePress("/"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade100,
                    ),
                    child: Text("=", style: TextStyle(fontSize: 20, color: Colors.redAccent)),
                    onPressed: () => _handlePress("="),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}