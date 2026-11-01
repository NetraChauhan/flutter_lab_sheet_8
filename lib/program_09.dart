import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFB45309)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 List<Map<String,Object?>> expenses=[];double total=0;
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q09.db',['CREATE TABLE IF NOT EXISTS expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)']);
 Future load()async{var d=await db();expenses=await d.query('expenses');if(expenses.isEmpty){await d.insert('expenses',{'title':'Books','amount':850.0});await d.insert('expenses',{'title':'Travel','amount':420.0});expenses=await d.query('expenses');}var r=await d.rawQuery('SELECT SUM(amount) AS total FROM expenses');total=(r.first['total'] as num?)?.toDouble()??0;setState((){});}
 Widget build(x)=>LabScreen(title:'Total Expense',subtitle:'SUM(amount) from SQLite',color:const Color(0xFFB45309),icon:Icons.calculate_rounded,child:Column(children:[
  Container(width:double.infinity,padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:const Color(0xFFFFF7ED),borderRadius:BorderRadius.circular(18)),child:Column(children:[const Text('TOTAL EXPENSE',style:TextStyle(fontWeight:FontWeight.w700,color:Colors.black54)),const SizedBox(height:5),Text('₹'+total.toStringAsFixed(2),style:const TextStyle(fontSize:34,fontWeight:FontWeight.w900))])),
  const SizedBox(height:14),...expenses.map((e)=>ListTile(title:Text(e['title'].toString()),trailing:Text('₹'+e['amount'].toString())))
 ]));
}
