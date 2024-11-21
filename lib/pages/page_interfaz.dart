import 'package:flutter/material.dart';
import '../logica/cantidad_digitos.dart';

class InterfazNumeros extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InterfazNumerosState();
}

class InterfazNumerosState extends State<InterfazNumeros> {
  final TextEditingController _controllerNum = TextEditingController();

  //declara variables
  int _numero = 0;
  int _cantidadDigitos = 0;

  //Instancia de la clase CantidadDigitosIngresados
  CantidadDigitosIngresados cantidadDigitos = CantidadDigitosIngresados();

  // Clave global para ScaffoldMessenger
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Función para mostrar SnackBar
  void mostrarSnackBar(String mensaje, Color color) {
    _scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar() // Oculta cualquier SnackBar activo
      ..showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: color,
          duration: Duration(seconds: 2), // Duración limitada
        ),
      );
  }

  //Funcion mostrar digitos
  void _mostrarDigitos() {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

    setState(() {
      //validar la entrada que solo sean numeros y no vacio y solo hasta 4 digitos
      int? numero = int.tryParse(_controllerNum.text);
      if (numero == null) {
        mostrarSnackBar("Ingrese un número válido", Colors.red);
        _cantidadDigitos = 0;
        _controllerNum.clear();
        return;
      }else if(numero < 0 || numero > 9999) {
        mostrarSnackBar("La cantidad máxima de digitos son cuatro", Colors.red);
        _cantidadDigitos = 0;
        _controllerNum.clear();
      }else {
        _numero = numero;
        _cantidadDigitos = cantidadDigitos.cantidadDigitos(_numero);
        mostrarSnackBar(
            "El número $_numero tiene $_cantidadDigitos dígitos", Colors.green);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey, // Asociar la clave global
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cantidad de dígitos",
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controllerNum,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingrese un número",
                  labelStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _mostrarDigitos,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.done_all_sharp),
                    SizedBox(width: 8),
                    Text("Mostrar Cantidad de Dígitos"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Cantidad de dígitos ingresados: $_cantidadDigitos",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
