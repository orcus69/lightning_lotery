import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lightning_lotery/common/buttom/buttonWidget.dart';
import 'package:lightning_lotery/common/qrCodeWidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerEmail  = TextEditingController();
  List<num> _selected = List.generate(60, (index) => index*index);
  List<num> _selecteValue =[];
  bool _loading = false;

  set loading(bool value) => setState((){_loading = value;});
  bool get loading => _loading;

  //Consumindo API Lightning-Lotery
  //Realizando requisição POST
  jsonApostar(List<num> numbers, String email) async {

    loading = true;

    final dio = Dio();
    //or works once
    var response = await dio.post(
      'http://lightning-lottery.herokuapp.com/apostar',
      data: {
        "numeros" : numbers, 
        "email" : email
      },
    );

    loading = false;

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buttom(),
            const SizedBox(height: 16, width: 290, child: Divider(),),
            _buildSelectedNumbers(),
            const SizedBox(height: 16),
            _buildEmail(),
            const SizedBox(height: 16),
            _buildSubmit(),
          ],
        )
      ),
    );
  }

  Widget _buttom(){

    var k = 1;

    return Center(
      child: SizedBox(
        width: 310,
        
        child: MultiSelectChipDisplay(
          alignment: Alignment.center,
          chipWidth: 16,
          chipColor: Colors.grey[200],
          textStyle: TextStyle(color: Colors.black),
          items: _selected.map((e) => MultiSelectItem(k++, "${k-1}".padLeft(2, '0'))).toList(),
          onTap: (value) {
            setState(() {
              if(!_selecteValue.contains(value as num))
                _selecteValue.add(value as num);
              return;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSelectedNumbers(){
    return SizedBox(
      width: 290,
      child: MultiSelectChipDisplay(
        chipColor: _selecteValue.length <= 5 ? Colors.blue[200] : _selecteValue.length > 14 ? Colors.red : Colors.green,
        textStyle: TextStyle(color: Colors.white),
        items: _selecteValue.map((e) => MultiSelectItem(e, e.toString().padLeft(2, '0'))).toList(),
        onTap: (value) {
          setState(() {

            _selecteValue.remove(value);
          });
        },
      ),
    );
  }

  Widget _buildEmail() => Card(
    child: Container(
      constraints: BoxConstraints.tight(Size(290, 40)),
      child: TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          
          
          labelText: 'E-mail',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (email) => email != null && email.isEmpty ? 'Insira um e-mail' : null,
      ),
    ),
  );

  Widget _buildSubmit() => SizedBox(
    
    width: 290,
    height: 40,
    child: loading 
      ? Container(alignment: Alignment.center, child: CircularProgressIndicator(color: Colors.blueAccent))
      : ButtonWidget(
      color: Color.fromARGB(255, 38, 164, 255),
      textColor: Colors.white,
      text: 'Enviar',
      onClicked: ()async{
        final form = formKey.currentState!;
        final isValid = form.validate();
        if(isValid){
          if(_selecteValue.length >= 6){
            if( _selecteValue.length <= 14){
              //Apostar
              var response = await jsonApostar(_selecteValue, controllerEmail.text);
              
              //Mostra QRcode
              showDialog(
                context: context, 
                builder: (_)=> QrcodeWidget(response: response)
              );


            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Selecione no maximo 14 números"),
                  backgroundColor: Colors.red,
                )
              );
            }
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Selecione pelo menos 6 números"),
                backgroundColor: Colors.orange,
              )
            );
          }
        }

      },
    ),
  );
}