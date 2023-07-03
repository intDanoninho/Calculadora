import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();
  String result = "0";
 _handleSubmitted(String value) {
    setState(() {
      
    inputK = _textController.text;
    inputK=inputK.toUpperCase();
    result= calculate(inputK);
    result = result.replaceAll(".0","");
    if(result!="Error" && result!="NaN" && result!="Infinity"){
        n = int.parse(result);
        result = n.toRadixString(16);
        result=result.toUpperCase();
      }
    });
  }
  String input = "";
  String inputK = "";
  int n=0;
  bool equalpressed=false;
  List<String> buttons = [
    'D', 'E', 'F', '=',
    'A', 'B', 'C', '/',
    '7','8', '9', '*',
    '4','5', '6', '+',
    '1', '2', '3', '-', 
    '(' , '0',')', 'X'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column (
          children: [
            Flexible(child: rWidget(), flex: 0),
            Flexible(child: bWidget(), flex: 2),

          ],
          ),
          ),
           );
  }
  Widget rWidget(){
    return Column(
      children: [
        TextField(
            controller: _textController,
            decoration: InputDecoration( 
                hintText: 'digite aqui...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: (){ _textController.clear();}, icon: const Icon(Icons.clear),)

            ),
            
            onSubmitted: 
                _handleSubmitted
          
            
            ),
         
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            input, style: const TextStyle(fontSize: 32),
          ),
          ),
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerRight ,
          child: Text(
            result, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            
          ),
          ),
          
      ]
      
      );
  }
  
  Widget bWidget(){
    return GridView.builder(
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.35),
      itemBuilder: (BuildContext context, int index) {
        return button(buttons[index]);
      },
    );
  }
  Widget button(String text){
    return Container(
      margin: const EdgeInsets.all(2),
      child: MaterialButton(onPressed: () {
        setState((){
          
          handleb(text);
        });
      },
      color: Colors.blue,
      textColor: Colors.white,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      shape: const CircleBorder(),
      )
    );
  }
  handleb(String text){
    if(text=="X"){
      if (input.length>0){
        input=input.substring(0,input.length-1);
      }
      return;
    }
    if (text=="="){
      result = calculate(input);
      result = result.replaceAll(".0","");
      if(result=="Error" || result=="NaN" || result=="Infinity"){
        return result;

      }
      int n = int.parse(result);
      result = n.toRadixString(16);
      result=result.toUpperCase();
      equalpressed=true;
      return result;

    }
    if(equalpressed==true){
      input="";
      equalpressed=false;
    }
    input=input+text;
  }
  String calculate(input){
    input= input.replaceAll( 'A', '10');
    input= input.replaceAll( 'B', '11');
    input= input.replaceAll( 'C', '12');
    input= input.replaceAll( 'D', '13');
    input= input.replaceAll( 'E', '14');
    input= input.replaceAll( 'F', '15');
    try{
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
      
  } catch(e){
    return "Error";
  }
}
}
