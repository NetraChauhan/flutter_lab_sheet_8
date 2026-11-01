import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF4F46E5)),home:const StudentList()));
Future db()=>openLabDb('q14.db',['CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)']);
class StudentList extends StatefulWidget{const StudentList({super.key});State<StudentList> createState()=>LS();}
class LS extends State<StudentList>{
 List<Map<String,Object?>> list=[];void initState(){super.initState();load();}
 Future load()async{list=await (await db()).query('students',orderBy:'name');setState((){});}
 Future open([Map<String,Object?>? s])async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>StudentForm(student:s)));load();}
 Widget build(c)=>LabScreen(title:'Student List',subtitle:'Navigator + SQLite database',color:const Color(0xFF4F46E5),icon:Icons.school_rounded,child:Column(children:[
  Align(alignment:Alignment.centerRight,child:FilledButton.icon(onPressed:()=>open(),icon:const Icon(Icons.add),label:const Text('Add Student'))),const SizedBox(height:12),
  if(list.isEmpty)emptyState(Icons.people_outline,'No students added'),
  ...list.map((s)=>Card(child:ListTile(title:Text(s['name'].toString()),subtitle:Text(s['roll'].toString()+' • '+s['course'].toString()),trailing:const Icon(Icons.edit),onTap:()=>open(s))))
 ]));
}
class StudentForm extends StatefulWidget{final Map<String,Object?>? student;const StudentForm({super.key,this.student});State<StudentForm> createState()=>FS();}
class FS extends State<StudentForm>{
 final n=TextEditingController(),r=TextEditingController(),c=TextEditingController();
 void initState(){super.initState();var s=widget.student;if(s!=null){n.text=s['name'].toString();r.text=s['roll'].toString();c.text=s['course'].toString();}}
 Future save()async{var d=await db();var m={'name':n.text,'roll':r.text,'course':c.text};widget.student==null?await d.insert('students',m):await d.update('students',m,where:'id=?',whereArgs:[widget.student!['id']]);if(mounted)Navigator.pop(context);}
 Widget build(x)=>Scaffold(appBar:AppBar(title:Text(widget.student==null?'Add Student':'Edit Student')),body:Padding(padding:const EdgeInsets.all(24),child:Column(children:[field(n,'Name'),field(r,'Roll Number'),field(c,'Course'),SizedBox(width:double.infinity,child:FilledButton(onPressed:save,child:Text(widget.student==null?'Add Student':'Update Student')))])));
}
