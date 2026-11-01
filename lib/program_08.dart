import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFD97706)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final t=TextEditingController(),a=TextEditingController();List<Map<String,Object?>> expenses=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q08.db',['CREATE TABLE IF NOT EXISTS expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount REAL)']);
 Future load()async{expenses=await (await db()).query('expenses',orderBy:'id DESC');setState((){});}
 Future add()async{await (await db()).insert('expenses',{'title':t.text,'amount':double.tryParse(a.text)??0});t.clear();a.clear();load();}
 Widget build(x)=>LabScreen(title:'Expense Tracker',subtitle:'Track title + amount in SQLite',color:const Color(0xFFD97706),icon:Icons.account_balance_wallet_rounded,child:Column(children:[
  field(t,'Expense Title'),field(a,'Amount',keyboard:TextInputType.number),SizedBox(width:double.infinity,child:FilledButton(onPressed:add,child:const Text('Add Expense'))),const SizedBox(height:14),
  ...expenses.map((e)=>Card(child:ListTile(title:Text(e['title'].toString()),trailing:Text('₹'+e['amount'].toString(),style:const TextStyle(fontWeight:FontWeight.w800)))))
 ]));
}
