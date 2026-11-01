import 'package:flutter/material.dart';

ThemeData labTheme(Color seed)=>ThemeData(
  useMaterial3:true,
  colorScheme:ColorScheme.fromSeed(seedColor:seed),
  scaffoldBackgroundColor:const Color(0xFFF7F8FC),
  inputDecorationTheme:InputDecorationTheme(
    filled:true,fillColor:Colors.white,
    border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none),
  ),
  cardTheme:CardThemeData(
    elevation:0,color:Colors.white,
    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
  ),
);

class LabScreen extends StatelessWidget{
  final String title,subtitle;
  final Color color;
  final IconData icon;
  final Widget child;
  final bool centered;
  const LabScreen({super.key,required this.title,required this.subtitle,required this.color,required this.icon,required this.child,this.centered=false});

  @override Widget build(BuildContext context)=>Scaffold(
    body:SafeArea(child:Center(child:ConstrainedBox(
      constraints:const BoxConstraints(maxWidth:820),
      child:ListView(padding:const EdgeInsets.all(26),children:[
        centered
          ?Column(children:[
              CircleAvatar(radius:34,backgroundColor:color.withOpacity(.12),child:Icon(icon,color:color,size:34)),
              const SizedBox(height:14),Text(title,textAlign:TextAlign.center,style:const TextStyle(fontSize:30,fontWeight:FontWeight.w800)),
              const SizedBox(height:5),Text(subtitle,textAlign:TextAlign.center,style:const TextStyle(color:Colors.black54)),
            ])
          :Container(
              padding:const EdgeInsets.all(22),
              decoration:BoxDecoration(
                gradient:LinearGradient(colors:[color,color.withOpacity(.72)]),
                borderRadius:BorderRadius.circular(25),
              ),
              child:Row(children:[
                Container(width:58,height:58,decoration:BoxDecoration(color:Colors.white.withOpacity(.16),borderRadius:BorderRadius.circular(18)),child:Icon(icon,color:Colors.white,size:30)),
                const SizedBox(width:16),
                Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Text(title,style:const TextStyle(color:Colors.white,fontSize:27,fontWeight:FontWeight.w800)),
                  const SizedBox(height:5),Text(subtitle,style:TextStyle(color:Colors.white.withOpacity(.86))),
                ])),
              ]),
            ),
        const SizedBox(height:20),
        Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(22),boxShadow:[BoxShadow(color:color.withOpacity(.08),blurRadius:20,offset:const Offset(0,8))]),child:child),
      ]),
    ))),
  );
}

Widget field(TextEditingController c,String label,{bool obscure=false,TextInputType? keyboard,int maxLines=1})=>Padding(
  padding:const EdgeInsets.only(bottom:12),
  child:TextField(controller:c,obscureText:obscure,keyboardType:keyboard,maxLines:maxLines,decoration:InputDecoration(labelText:label)),
);

Widget emptyState(IconData icon,String text)=>Padding(
  padding:const EdgeInsets.symmetric(vertical:30),
  child:Column(children:[Icon(icon,size:48,color:Colors.black26),const SizedBox(height:10),Text(text,style:const TextStyle(color:Colors.black54))]),
);
