import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF0369A1)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final q=TextEditingController();List<Map<String,Object?>> notes=[];
 void initState(){super.initState();seed();}
 Future db()=>openLabDb('q04.db',['CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)']);
 Future seed()async{var d=await db();if((await d.query('notes')).isEmpty){for(final x in ['Flutter Basics','SQLite Search','Exam Notes']){await d.insert('notes',{'title':x,'content':'Saved note'});}}search('');}
 Future search(String s)async{var d=await db();notes=await d.query('notes',where:'title LIKE ?',whereArgs:['%'+s+'%']);if(mounted)setState((){});}
 Widget build(x)=>LabScreen(title:'Search Notes',subtitle:'Search by title using SQLite query',color:const Color(0xFF0369A1),icon:Icons.search_rounded,child:Column(children:[
  TextField(controller:q,onChanged:search,decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search note title...')),const SizedBox(height:14),
  ...notes.map((n)=>Card(child:ListTile(title:Text(n['title'].toString()),subtitle:Text(n['content'].toString()))))
 ]));
}
