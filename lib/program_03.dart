import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFB91C1C)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 List<Map<String,Object?>> notes=[];
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q03.db',['CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT)']);
 Future load()async{var d=await db();notes=await d.query('notes');if(notes.isEmpty){for(final x in ['Database Revision','Flutter Widgets','Lab Record']){await d.insert('notes',{'title':x,'content':'Swipe left or right to delete'});}notes=await d.query('notes');}setState((){});}
 Widget build(x)=>LabScreen(title:'Swipe to Delete',subtitle:'Dismissible + SnackBar',color:const Color(0xFFB91C1C),icon:Icons.swipe_rounded,child:Column(children:[
  ...notes.map((n)=>Dismissible(key:ValueKey(n['id']),background:Container(color:Colors.red.shade100,alignment:Alignment.centerLeft,padding:const EdgeInsets.all(20),child:const Icon(Icons.delete,color:Colors.red)),onDismissed:(d)async{
    await (await db()).delete('notes',where:'id=?',whereArgs:[n['id']]);notes.remove(n);setState((){});
    if(mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(n['title'].toString()+' deleted')));
  },child:Card(child:ListTile(title:Text(n['title'].toString()),subtitle:Text(n['content'].toString())))))
 ]));
}
