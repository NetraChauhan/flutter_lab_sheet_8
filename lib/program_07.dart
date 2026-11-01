import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF059669)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final q=TextEditingController();List<Map<String,Object?>> contacts=[];
 void initState(){super.initState();seed();}
 Future db()=>openLabDb('q07.db',['CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)']);
 Future seed()async{var d=await db();if((await d.query('contacts')).isEmpty){for(final a in [['Aarav Mehta','9812345678'],['Mira Kapoor','9876543210'],['Kabir Shah','9898989898']]){await d.insert('contacts',{'name':a[0],'phone':a[1]});}}search('');}
 Future search(String s)async{contacts=await (await db()).query('contacts',where:'name LIKE ?',whereArgs:['%'+s+'%'],orderBy:'name');setState((){});}
 Widget build(x)=>LabScreen(title:'Search Contacts',subtitle:'SQLite LIKE operator',color:const Color(0xFF059669),icon:Icons.manage_search_rounded,child:Column(children:[
  TextField(controller:q,onChanged:search,decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search contact by name...')),const SizedBox(height:14),
  ...contacts.map((a)=>Card(child:ListTile(title:Text(a['name'].toString()),subtitle:Text(a['phone'].toString()))))
 ]));
}
