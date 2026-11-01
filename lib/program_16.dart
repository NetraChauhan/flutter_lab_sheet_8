import 'package:flutter/material.dart';import 'db.dart';import 'ui.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,theme:labTheme(const Color(0xFFDB2777)),home:const App()));
class App extends StatefulWidget{const App({super.key});State<App> createState()=>S();}
class S extends State<App>{
 final n=TextEditingController(),p=TextEditingController(),q=TextEditingController(text:'1');List<Map<String,Object?>> items=[];double total=0;
 void initState(){super.initState();load();}
 Future db()=>openLabDb('q16.db',['CREATE TABLE IF NOT EXISTS cart(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,price REAL,qty INTEGER)']);
 Future load()async{var d=await db();items=await d.query('cart');var r=await d.rawQuery('SELECT SUM(price*qty) AS total FROM cart');total=(r.first['total'] as num?)?.toDouble()??0;setState((){});}
 Future add()async{await (await db()).insert('cart',{'name':n.text,'price':double.tryParse(p.text)??0,'qty':int.tryParse(q.text)??1});n.clear();p.clear();q.text='1';load();}
 Widget build(x)=>LabScreen(title:'Shopping Cart',subtitle:'SQLite cart + total price',color:const Color(0xFFDB2777),icon:Icons.shopping_cart_rounded,child:Column(children:[
  Row(children:[Expanded(flex:2,child:field(n,'Item')),const SizedBox(width:8),Expanded(child:field(q,'Qty',keyboard:TextInputType.number)),const SizedBox(width:8),Expanded(child:field(p,'Price',keyboard:TextInputType.number))]),
  SizedBox(width:double.infinity,child:FilledButton(onPressed:add,child:const Text('Add to Cart'))),const SizedBox(height:14),
  Container(width:double.infinity,padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:const Color(0xFFFDF2F8),borderRadius:BorderRadius.circular(16)),child:Text('Total Price: ₹'+total.toStringAsFixed(2),style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900))),
  const SizedBox(height:10),...items.map((a)=>ListTile(leading:const Icon(Icons.shopping_bag_outlined),title:Text(a['name'].toString()),subtitle:Text('Qty '+a['qty'].toString()),trailing:Text('₹'+((a['price'] as num)*(a['qty'] as num)).toStringAsFixed(2))))
 ]));
}
