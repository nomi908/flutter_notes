import 'package:flutter/material.dart';
import 'package:notes_app/add_notes.dart';
import 'package:notes_app/data/local_data/dbhelper.dart';
import 'package:notes_app/db_provider.dart';
import 'package:notes_app/setting.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DBProvider(dhelper: DBHelper.getInstance)),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ], child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().getThemevalue() ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController despController = TextEditingController();
  // // List<Map<String, dynamic>> allNotes = [];
  // DBHelper? dbRef;


  @override
  void initState() {
    super.initState();
    // dbRef = DBHelper.getInstance;
    // getallNotes();

    context.read<DBProvider>().initNotesget();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,

        actions: [
          PopupMenuButton(itemBuilder: (_){
            return [PopupMenuItem(child: Row(
             children: [
              Icon(Icons.settings),
              Text("Setting"),
             ],
            
            ), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingPage()));
            },
            ),];
          })
          
        ],
      ),


      body: Consumer<DBProvider>(builder: (ctx, provider, __){
        List<Map<String, dynamic>> allNotes = provider.getNotes();

        return allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  // leading: Text("${allNotes[index][DBHelper.COLUMN_SRN]}"),
                  title: Text(allNotes[index][DBHelper.TEXT_TITLE], maxLines: 1, overflow: TextOverflow.ellipsis,),
                
                  subtitle: Text(allNotes[index][DBHelper.TEXT_DESP],   maxLines: 1, // Set maximum number of lines
                  overflow: TextOverflow.ellipsis, // Show ellipsis when text is too long
                 ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            titleController.text =
                            allNotes[index][DBHelper.TEXT_TITLE];
                            despController.text =
                            allNotes[index][DBHelper.TEXT_DESP];
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (context) {
                            //       return getBottomSheetWidget(context,
                            //           updateDB: true,
                            //           sno: allNotes[index]
                            //           [DBHelper.COLUMN_SRN]);

                            //     });

                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes(
                              updateDB: true, sno: allNotes[index][DBHelper.COLUMN_SRN],
                              nyTitle: allNotes[index][DBHelper.TEXT_TITLE],
                              ndDesp: allNotes[index][DBHelper.TEXT_DESP],
                            )));
                          },
                          icon: const Icon(
                            Icons.edit,
                          )),
                     IconButton(onPressed: () async {
                      //  bool delete = await dbRef!.deleteNotes(sno: allNotes[index][DBHelper.COLUMN_SRN]);
                      //  if(delete){
                      //    getallNotes();
                      //  }else{
                      //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("failed")));
                      //  }

                      context.read<DBProvider>().deleteNote(allNotes[index][DBHelper.COLUMN_SRN]);

                     }, icon: Icon(Icons.delete), color: Colors.red,)
                    ],
                  ),
                );
              })
          : const Center(
              child: Text("No Notes yet"),
            );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          despController.clear();
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return getBottomSheetWidget(context);
          //   });
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes()));

        },
        child: const Icon(Icons.add),
      ),

    );
  }


  // void getallNotes() async {
  //   allNotes = await dbRef!.getallNotes();
  //   setState(() {});
  // }

//newbottomsheet
  // Widget getBottomSheetWidget(BuildContext context ,{bool updateDB = false, int sno = 0}) {
  //   return 
  // }


}
