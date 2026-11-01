import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFEA580C)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 List<Map<String,Object?>> contacts=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q06.db',['CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)']);
 Future load()async{var d=await db();contacts=await d.query('contacts');if(contacts.isEmpty){await d.insert('contacts',{'name':'Mira Kapoor','phone':'9876543210'});await d.insert('contacts',{'name':'Aarav Mehta','phone':'9812345678'});contacts=await d.query('contacts');}setState((){});}
 Future ask(Map<String,Object?> a)async{var ok=await showDialog<bool>(context:context,builder:(c)=>AlertDialog(title:const Text('Delete contact?'),content:Text('Remove '+a['name'].toString()+' from Contact Book?'),actions:[TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Delete'))]));if(ok==true){await (await db()).delete('contacts',where:'id=?',whereArgs:[a['id']]);contacts.remove(a);setState((){});}}
 Widget build(x)=>LabScreen(title:'Delete Contact',subtitle:'Confirmation using AlertDialog',color:const Color(0xFFEA580C),icon:Icons.person_remove_alt_1_rounded,child:Column(children:[
  ...contacts.map((a)=>Card(child:ListTile(title:Text(a['name'].toString()),subtitle:Text(a['phone'].toString()),trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:()=>ask(a)))))
 ]));
}
