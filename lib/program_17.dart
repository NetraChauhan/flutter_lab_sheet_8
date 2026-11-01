import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF312E81)),home:const Home()));
Future db()=>openLabDb('q17.db',['CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,course TEXT)']);

class Home extends StatelessWidget{
 const Home({super.key});
 Widget build(c)=>LabScreen(title:'Student Management',subtitle:'SQLite multi-screen application',color:const Color(0xFF312E81),icon:Icons.dashboard_rounded,centered:true,child:Column(children:[
  SizedBox(width:double.infinity,child:FilledButton.icon(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const AddStudent())),icon:const Icon(Icons.person_add),label:const Text('Add Student'))),
  const SizedBox(height:10),
  SizedBox(width:double.infinity,child:OutlinedButton.icon(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const StudentList())),icon:const Icon(Icons.list),label:const Text('Student List')))
 ]));
}

class AddStudent extends StatelessWidget{
 const AddStudent({super.key});
 Widget build(c)=>const StudentForm(title:'Add Student');
}
class UpdateStudent extends StatelessWidget{
 final Map<String,Object?> student;const UpdateStudent({super.key,required this.student});
 Widget build(c)=>StudentForm(title:'Update Student',student:student);
}

class StudentList extends StatefulWidget{const StudentList({super.key});State<StudentList> createState()=>LS();}
class LS extends State<StudentList>{
 List<Map<String,Object?>> list=[];void initState(){super.initState();load();}
 Future load()async{list=await (await db()).query('students',orderBy:'name');setState((){});}
 Future del(Map<String,Object?> s)async{var ok=await showDialog<bool>(context:context,builder:(c)=>AlertDialog(title:const Text('Delete student?'),content:Text('Delete '+s['name'].toString()+'?'),actions:[TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Delete'))]));if(ok==true){await (await db()).delete('students',where:'id=?',whereArgs:[s['id']]);load();}}
 Widget build(c)=>Scaffold(appBar:AppBar(title:const Text('Student List')),floatingActionButton:FloatingActionButton(onPressed:()async{await Navigator.push(c,MaterialPageRoute(builder:(_)=>const AddStudent()));load();},child:const Icon(Icons.add)),body:ListView(padding:const EdgeInsets.all(20),children:[
  if(list.isEmpty)emptyState(Icons.people_outline,'No students yet'),
  ...list.map((s)=>Card(child:ListTile(title:Text(s['name'].toString()),subtitle:Text(s['roll'].toString()+' • '+s['course'].toString()),trailing:Wrap(children:[
   IconButton(icon:const Icon(Icons.edit),onPressed:()async{await Navigator.push(c,MaterialPageRoute(builder:(_)=>UpdateStudent(student:s)));load();}),
   IconButton(icon:const Icon(Icons.delete,color:Colors.red),onPressed:()=>del(s))
  ]))))
 ]));
}

class StudentForm extends StatefulWidget{
 final String title;final Map<String,Object?>? student;
 const StudentForm({super.key,required this.title,this.student});
 State<StudentForm> createState()=>FS();
}
class FS extends State<StudentForm>{
 final key=GlobalKey<FormState>();final n=TextEditingController(),r=TextEditingController(),c=TextEditingController();
 void initState(){super.initState();var s=widget.student;if(s!=null){n.text=s['name'].toString();r.text=s['roll'].toString();c.text=s['course'].toString();}}
 Future save()async{if(!key.currentState!.validate())return;var d=await db();var m={'name':n.text,'roll':r.text,'course':c.text};widget.student==null?await d.insert('students',m):await d.update('students',m,where:'id=?',whereArgs:[widget.student!['id']]);if(mounted)Navigator.pop(context);}
 Widget build(x)=>Scaffold(appBar:AppBar(title:Text(widget.title)),body:Form(key:key,child:ListView(padding:const EdgeInsets.all(24),children:[
  TextFormField(controller:n,decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.trim().isEmpty?'Enter name':null),const SizedBox(height:12),
  TextFormField(controller:r,decoration:const InputDecoration(labelText:'Roll Number'),validator:(v)=>v==null||v.trim().isEmpty?'Enter roll number':null),const SizedBox(height:12),
  TextFormField(controller:c,decoration:const InputDecoration(labelText:'Course'),validator:(v)=>v==null||v.trim().isEmpty?'Enter course':null),const SizedBox(height:16),
  FilledButton(onPressed:save,child:Text(widget.student==null?'Add Student':'Update Student'))
 ])));
}
