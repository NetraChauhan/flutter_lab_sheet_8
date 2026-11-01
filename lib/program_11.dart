import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF9333EA)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final n=TextEditingController(),e=TextEditingController(),p=TextEditingController();String status='';
 Future db()=>openLabDb('q11.db',['CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)']);
 Future save()async{await (await db()).insert('users',{'name':n.text,'email':e.text,'password':p.text});setState(()=>status='Registration saved successfully');}
 Widget build(x)=>LabScreen(title:'Create Account',subtitle:'Registration stored in SQLite',color:const Color(0xFF9333EA),icon:Icons.person_add_alt_1_rounded,centered:true,child:Column(children:[
  field(n,'Name'),field(e,'Email',keyboard:TextInputType.emailAddress),field(p,'Password',obscure:true),SizedBox(width:double.infinity,child:FilledButton(onPressed:save,child:const Text('Register'))),
  if(status.isNotEmpty)Padding(padding:const EdgeInsets.only(top:14),child:Text(status,style:const TextStyle(color:Colors.green,fontWeight:FontWeight.w700)))
 ]));
}
