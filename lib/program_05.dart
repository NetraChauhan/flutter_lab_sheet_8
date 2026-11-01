import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF7C3AED)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final n=TextEditingController(),p=TextEditingController();List<Map<String,Object?>> contacts=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q05.db',['CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)']);
 Future load()async{contacts=await (await db()).query('contacts',orderBy:'name');setState((){});}
 Future add()async{await (await db()).insert('contacts',{'name':n.text,'phone':p.text});n.clear();p.clear();load();}
 Widget build(x)=>LabScreen(title:'Contact Book',subtitle:'Contacts stored in SQLite',color:const Color(0xFF7C3AED),icon:Icons.contacts_rounded,child:Column(children:[
  field(n,'Name'),field(p,'Phone Number',keyboard:TextInputType.phone),SizedBox(width:double.infinity,child:FilledButton(onPressed:add,child:const Text('Save Contact'))),const SizedBox(height:14),
  ...contacts.map((a)=>Card(child:ListTile(leading:CircleAvatar(child:Text(a['name'].toString().substring(0,1))),title:Text(a['name'].toString()),subtitle:Text(a['phone'].toString()))))
 ]));
}
