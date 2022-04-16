import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEtanol = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();

  String _textoResultado = "";

  void _calcular() {
    double? precoEtanol = double.tryParse(_controllerEtanol.text);
    double? precoGasolina = double.tryParse(_controllerGasolina.text);

    if (precoEtanol == null || precoGasolina == null) {
      setState(() {
        _textoResultado =
            "Número inválido. Digite números maiores que 0 e utilize (.)";
      });
    } else {
      //Caso resultado >= 0.7 é melhor utilizar gasolina, no contrário usa Etanol
      if ((precoEtanol / precoGasolina) >= 0.7) {
        setState(() {
          _textoResultado = "Abasteça com Gasolina";
        });
      } else {
        setState(() {
          _textoResultado = "Abasteça com Etanol";
        });
      }
    }
  }

  //Não é necessário chamar setState para os controllers dos campos. O processo é automático
  void _limparCampos() {
    _controllerEtanol.text = "";
    _controllerGasolina.text = "";
    setState(() {
      _textoResultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gasolina ou Etanol?"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        // SingleChildScrollView - scroll
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para o seu carro",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Preço do Etanol, ex: 3.99"),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerEtanol,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Preço da Gasolina, ex: 5.99"),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerGasolina,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _calcular,
                  child: Text(
                    "Calcular",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _limparCampos,
                  child: Text(
                    "Limpar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  this._textoResultado,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
