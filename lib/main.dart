import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightning_lotery/common/buttom/buttonWidget.dart';
import 'package:lightning_lotery/common/header/header.dart';
import 'package:lightning_lotery/common/qrCodeWidget.dart';
import 'package:lightning_lotery/utils/globals.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Lightning-Lottery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: Theme.of(context).copyWith(
        platform: TargetPlatform.android,
        scaffoldBackgroundColor: Color.fromRGBO(7, 17, 26, 1),
        primaryColor: Color.fromRGBO(21, 181, 114, 1),
        canvasColor: Color.fromRGBO(7, 17, 26, 1),
      ),
      builder: (context,widget)=>ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.resize(2460, name: "4K"),

        ],
        background: Container(
          color: Color.fromRGBO(7, 17, 26, 1),

        )
      ),
      home: MyHomePage(title: 'Lightning-Lottery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        "numeros" : "$numbers", 
        "email" : email
      },
    );

    loading = false;

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scafoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index){
                return headerItem[index].isButtom ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextButton(
                        onPressed: headerItem[index].onTap,
                        child: Text(
                          headerItem[index].title,
                          style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : ListTile(
                  title: Text(
                    headerItem[index].title,
                    style: TextStyle(color: Colors.white,),
                  ),
                );
              }, 
              separatorBuilder: (BuildContext context, int index){
                return SizedBox(
                  height: 10.0,
                );
              }, 
              itemCount: headerItem.length
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              Container(
                child: Header(),
              ),

              //body
              Container(
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
              ),
            ],
          ),
        ),
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
