import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF4F46E5)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final t=TextEditingController(),c=TextEditingController();List<Map<String,Object?>> notes=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q01.db',['CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)']);
 Future load()async{var d=await db();notes=await d.query('notes',orderBy:'id DESC');if(mounted)setState((){});}
 Future add()async{var d=await db();await d.insert('notes',{'title':t.text,'content':c.text});t.clear();c.clear();await load();}
 Widget build(x)=>LabScreen(title:'My Notes',subtitle:'SQLite Notes • title + content',color:const Color(0xFF4F46E5),icon:Icons.note_alt_rounded,child:Column(children:[
  field(t,'Title'),field(c,'Content',maxLines:3),SizedBox(width:double.infinity,child:FilledButton.icon(onPressed:add,icon:const Icon(Icons.add),label:const Text('Add Note'))),
  const SizedBox(height:14),if(notes.isEmpty)emptyState(Icons.note_outlined,'No notes yet'),
  ...notes.map((n)=>Card(child:ListTile(title:Text(n['title'].toString()),subtitle:Text(n['content'].toString()))))
 ]));
}
