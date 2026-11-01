import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF2563EB)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final t=TextEditingController();List<Map<String,Object?>> tasks=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q10.db',['CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,completed INTEGER)']);
 Future load()async{var d=await db();tasks=await d.query('tasks');if(tasks.isEmpty){await d.insert('tasks',{'title':'Complete lab record','completed':0});await d.insert('tasks',{'title':'Revise SQLite','completed':1});tasks=await d.query('tasks');}setState((){});}
 Future add()async{await (await db()).insert('tasks',{'title':t.text,'completed':0});t.clear();load();}
 Future toggle(Map<String,Object?> task,bool v)async{await (await db()).update('tasks',{'completed':v?1:0},where:'id=?',whereArgs:[task['id']]);load();}
 Widget build(x)=>LabScreen(title:'SQLite To-Do',subtitle:'Checkbox updates completed status',color:const Color(0xFF2563EB),icon:Icons.checklist_rounded,child:Column(children:[
  Row(children:[Expanded(child:TextField(controller:t,decoration:const InputDecoration(hintText:'New task'))),const SizedBox(width:8),FilledButton(onPressed:add,child:const Text('Add'))]),const SizedBox(height:14),
  ...tasks.map((task)=>CheckboxListTile(value:task['completed']==1,onChanged:(v)=>toggle(task,v!),title:Text(task['title'].toString()),subtitle:Text(task['completed']==1?'Completed':'Pending')))
 ]));
}
