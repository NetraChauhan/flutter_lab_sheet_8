import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF0F766E)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final t=TextEditingController(),c=TextEditingController();List<Map<String,Object?>> notes=[];int? edit;
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q02.db',['CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)']);
 Future load()async{var d=await db();notes=await d.query('notes');if(notes.isEmpty){await d.insert('notes',{'title':'Flutter Lab','content':'Edit me by tapping this note'});notes=await d.query('notes');}setState((){});}
 Future save()async{var d=await db();if(edit==null){await d.insert('notes',{'title':t.text,'content':c.text});}else{await d.update('notes',{'title':t.text,'content':c.text},where:'id=?',whereArgs:[edit]);}edit=null;t.clear();c.clear();load();}
 Widget build(x)=>LabScreen(title:'Edit Notes',subtitle:'Tap any note to edit it',color:const Color(0xFF0F766E),icon:Icons.edit_note_rounded,child:Column(children:[
  field(t,'Title'),field(c,'Content',maxLines:2),FilledButton(onPressed:save,child:Text(edit==null?'Add Note':'Save Changes')),const SizedBox(height:12),
  ...notes.map((n)=>Card(child:ListTile(title:Text(n['title'].toString()),subtitle:Text(n['content'].toString()),trailing:const Icon(Icons.edit),onTap:(){edit=n['id'] as int;t.text=n['title'].toString();c.text=n['content'].toString();setState((){});}))
 ]));
}
