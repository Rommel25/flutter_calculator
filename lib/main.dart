import 'package:flutter/material.dart';

void main() => runApp(CalculatriceApp());

class CalculatriceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculatrice(),
    );
  }
}

class Calculatrice extends StatefulWidget {
  @override
  _CalculatriceState createState() => _CalculatriceState();
}

class _CalculatriceState extends State<Calculatrice> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool operatorPressed = false;

  void boutonAppuye(String bouton) {
    // Si C est appuyé, réinitialiser tout
    if (bouton == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      operatorPressed = false;
    }
    // Si = est appuyé, calculer le résultat
    else if (bouton == "=") {
      if (operand == "") {
        return; // Pas d'opération à effectuer
      }

      // Extraire le deuxième nombre (après l'opérateur)
      String secondNumberStr = _output.substring(_output.indexOf(operand) + 1);
      if (secondNumberStr.isEmpty) {
        return; // Pas de deuxième nombre
      }

      num2 = double.parse(secondNumberStr);

      //Cas de calcul pour chaque opérator
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        if (num2 == 0) {
          _output = "Error";  // Faire attention à la division par 0
        } else {
          _output = (num1 / num2).toString();
        }
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      operatorPressed = false;
    }
    // Si un opérateur est appuyé
    else if (bouton == "+" || bouton == "-" || bouton == "*" || bouton == "/") {
      if (!operatorPressed) {
        num1 = double.parse(_output);
        operand = bouton;
        _output = _output + bouton; // Ajouter l'opérateur à l'affichage pour voir le calcul
        operatorPressed = true;
      }
    }
    // Si un nombre est appuyé
    else {
      if (_output == "0") {
        _output = bouton;
      } else {
        _output = _output + bouton;
      }
    }

    // Mise à jour de l'affichage
    setState(() {
      output = _output;
      // Supprimer le .0 si le résultat est un entier
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculatrice Flutter'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                List<String> buttons = [
                  '7', '8', '9', '/',
                  '4', '5', '6', '*',
                  '1', '2', '3', '-',
                  'C', '0', '=', '+'
                ];
                return ElevatedButton(
                  onPressed: () {
                    boutonAppuye(buttons[index]);
                  },
                  child: Text(
                    buttons[index],
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}