import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController data = new TextEditingController();
  TextEditingController keys = new TextEditingController();
  String resul='';
  List<String> alfabit=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  int indexvalue(List<String> alfa,String chart){
    for(int i=0;i<alfa.length;i++){

      if(alfa[i]==chart){
        return i;
      }
    }
    return 0;
  }
  String encription(String plain,int key){
    List cipher=[];
    List<String> result=plain.split('');
    for(int i=0;i<result.length;i++){
      int val=indexvalue(alfabit, result[i]);
      cipher.add(alfabit[(val+key)%26]);
    }

    //List<String> result = plain.split('');
return cipher.join();
  }
  String decryption(String ci,int key){
    List<String> pl=[];
    List<String> result=ci.split('');
    for(int i =0;i<result.length;i++){
      int va=indexvalue(alfabit, result[i]);
      pl.add(alfabit[(va-key)%26]);
    }
    return pl.join();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('خوارزميه قيصر'),
      ),
      body: ListView(children: [
        Form(child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            TextField(
               controller: data,
              decoration: InputDecoration(
                labelText: 'ادخل البيانات',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: keys,
              decoration: InputDecoration(
                labelText: 'ادخل المفتاح',
                border: OutlineInputBorder(),
              ),
            )


          ],
        )),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: RaisedButton(child: Text('فك التشفير'),onPressed: (){
              setState(() {
                
                resul = decryption(data.text, int.parse(keys.text));
              });
            },)),
            SizedBox(width: 20),
            Expanded(child: RaisedButton(child: Text(' التشفير'),onPressed: (){
              setState(() {
                resul=encription(data.text, int.parse(keys.text));
                print(encription(data.text, 5));
                print(data.text);
                print(keys.text);
                print(indexvalue(alfabit, 'D'));
              });
            },))
          ],),

        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(width: MediaQuery.of(context).size.width,height: 300,
          decoration: BoxDecoration(
            border: Border.all(width: 2,color: Colors.grey)
          ),
            child: Text(resul),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Expanded(child: RaisedButton(child: Text('Copy'),onPressed: (){Clipboard.setData(ClipboardData(text: resul),);},)),
            SizedBox(width: 20),
            Expanded(child: RaisedButton(child: Text(' Reset'),onPressed: (){
              setState(() {
                data.text='';
                keys.text='';
                resul='result';
              });
            },))
          ],),
        ),
      ],),
    );
  }
}