import 'package:flutter/material.dart';
import 'package:moneyconverser/widgets/build.text.field.dart';
import '../provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double dolar;
  double euro;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text =(real/dolar).toStringAsFixed(2);
    euroController.text =(real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro*this.euro).toStringAsFixed(2);
    dolarController.text = (euro*this.euro/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('\$ Money Converter \$'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child:FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text('Carregando dados',
                  style:TextStyle(color:Colors.amber), textAlign: TextAlign.center,
                ),
              );
              default:
                if(snapshot.hasError){
                  Center(child: Text('Erro ao carregar dados :\(',
                  style:TextStyle(color:Colors.amber),textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  
                return SingleChildScrollView(
                  padding:EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:<Widget>[
                      Icon(Icons.monetization_on, size: 150, color:Colors.amber),
                      TextFieldBuilder( label: 'Reais', prefix: 'R\$', c:realController, f:_realChanged),
                      Divider(),
                      TextFieldBuilder( label: 'Dólares', prefix: 'U\$', c:dolarController, f:_dolarChanged),
                      Divider(),
                      TextFieldBuilder(  label: 'Euros', prefix: '€', c:euroController, f:_euroChanged)
                    ]
                  )
                );
              }
            }
          },
        )
      ),
    );
  }
}