import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFF047857)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final n=TextEditingController(),q=TextEditingController(),p=TextEditingController();List<Map<String,Object?>> products=[];int? edit;
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q15.db',['CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,quantity INTEGER,price REAL)']);
 Future load()async{products=await (await db()).query('products',orderBy:'name');setState((){});}
 Future save()async{var d=await db();var m={'name':n.text,'quantity':int.tryParse(q.text)??0,'price':double.tryParse(p.text)??0};edit==null?await d.insert('products',m):await d.update('products',m,where:'id=?',whereArgs:[edit]);edit=null;n.clear();q.clear();p.clear();load();}
 Future remove(int id)async{await (await db()).delete('products',where:'id=?',whereArgs:[id]);load();}
 Widget build(x)=>LabScreen(title:'Product Inventory',subtitle:'Add • Update • Delete products',color:const Color(0xFF047857),icon:Icons.inventory_2_rounded,child:Column(children:[
  field(n,'Product Name'),Row(children:[Expanded(child:field(q,'Quantity',keyboard:TextInputType.number)),const SizedBox(width:10),Expanded(child:field(p,'Price',keyboard:TextInputType.number))]),
  SizedBox(width:double.infinity,child:FilledButton(onPressed:save,child:Text(edit==null?'Add Product':'Update Product'))),const SizedBox(height:14),
  ...products.map((a)=>Card(child:ListTile(title:Text(a['name'].toString()),subtitle:Text('Qty: '+a['quantity'].toString()+' • ₹'+a['price'].toString()),trailing:Wrap(children:[
   IconButton(icon:const Icon(Icons.edit_outlined),onPressed:(){edit=a['id'] as int;n.text=a['name'].toString();q.text=a['quantity'].toString();p.text=a['price'].toString();setState((){});}),
   IconButton(icon:const Icon(Icons.delete_outline,color:Colors.red),onPressed:()=>remove(a['id'] as int))
  ]))))
 ]));
}
