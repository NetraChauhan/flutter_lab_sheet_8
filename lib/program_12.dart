import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF0F766E)),home:const Login()));
class Login extends StatefulWidget{const Login({super.key});State<Login> createState()=>S();}
class S extends State<Login>{
 final u=TextEditingController(text:'netra@example.com'),p=TextEditingController(text:'123456');String error='';
 Future db()=>openLabDb('q12.db',['CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)']);
 void initState(){super.initState();seed();}
 Future seed()async{var d=await db();if((await d.query('users')).isEmpty){await d.insert('users',{'name':'Netra','email':'netra@example.com','password':'123456'});}}
 Future login()async{var r=await (await db()).query('users',where:'email=? AND password=?',whereArgs:[u.text,p.text]);if(r.isNotEmpty&&mounted){Navigator.push(context,MaterialPageRoute(builder:(_)=>Home(name:r.first['name'].toString())));}else{setState(()=>error='Invalid username or password');}}
 Widget build(x)=>LabScreen(title:'Welcome Back',subtitle:'Login validated against SQLite',color:const Color(0xFF0F766E),icon:Icons.lock_open_rounded,centered:true,child:Column(children:[
  field(u,'Username / Email'),field(p,'Password',obscure:true),SizedBox(width:double.infinity,child:FilledButton(onPressed:login,child:const Text('Login'))),
  const SizedBox(height:10),const Text('Demo: netra@example.com / 123456',style:TextStyle(color:Colors.black45)),if(error.isNotEmpty)Text(error,style:const TextStyle(color:Colors.red))
 ]));
}
class Home extends StatelessWidget{final String name;const Home({super.key,required this.name});Widget build(c)=>Scaffold(body:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.home_rounded,size:64,color:Color(0xFF0F766E)),const SizedBox(height:12),Text('Welcome, '+name+'!',style:const TextStyle(fontSize:28,fontWeight:FontWeight.w800)),const Text('Login successful • Home Screen')])));}
