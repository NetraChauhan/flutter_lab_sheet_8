import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFDC2626)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final key=GlobalKey<FormState>();final n=TextEditingController(),e=TextEditingController(),p=TextEditingController();String msg='';
 Future db()=>openLabDb('q13.db',['CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)']);
 Future save()async{if(!key.currentState!.validate())return;await (await db()).insert('users',{'name':n.text,'email':e.text,'password':p.text});setState(()=>msg='Valid record inserted into SQLite');}
 Widget build(x)=>LabScreen(title:'Validated Registration',subtitle:'Form + TextFormField validation',color:const Color(0xFFDC2626),icon:Icons.verified_user_rounded,child:Form(key:key,child:Column(children:[
  TextFormField(controller:n,decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.trim().isEmpty?'Name cannot be empty':null),
  const SizedBox(height:12),
  TextFormField(controller:e,keyboardType:TextInputType.emailAddress,decoration:const InputDecoration(labelText:'Email'),validator:(v)=>v!=null&&RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)?null:'Enter a valid email'),
  const SizedBox(height:12),
  TextFormField(controller:p,obscureText:true,decoration:const InputDecoration(labelText:'Password'),validator:(v)=>v!=null&&v.length>=6?null:'Minimum 6 characters'),
  const SizedBox(height:14),SizedBox(width:double.infinity,child:FilledButton(onPressed:save,child:const Text('Validate & Save'))),
  if(msg.isNotEmpty)Padding(padding:const EdgeInsets.only(top:12),child:Text(msg,style:const TextStyle(color:Colors.green,fontWeight:FontWeight.w700)))
 ])));
}
