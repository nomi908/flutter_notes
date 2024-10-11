import 'package:flutter/material.dart';
import 'package:notes_app/db_provider.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatelessWidget {

  bool updateDB;
  String nyTitle;
  String ndDesp;
  int sno;
  TextEditingController titleController = TextEditingController();
  TextEditingController despController = TextEditingController();

  // DBHelper? dbRef = DBHelper.getInstance;

  AddNotes({this.updateDB = false, this.nyTitle = "", this.ndDesp = "", this.sno = 0});

  @override
  Widget build(BuildContext context) {
    if(updateDB){
     titleController.text = nyTitle;
     despController.text = ndDesp;
    }
    return Scaffold(
      appBar: AppBar(title: Text(updateDB ? "Update Note" : "Add Note",),),
      body: Container(
      padding: const EdgeInsets.all(11),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Text(
              updateDB ? "Update Note" : "Add Note",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 21),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter Your Title",
                label: const Text("Title"),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
            ),
            const SizedBox(height: 21),
            TextField(
              controller: despController,
              maxLines: 4,
              decoration: InputDecoration(
                label: const Text("Description"),
                alignLabelWithHint: true,
                hintText: "Enter your Description",
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
            ),
            const SizedBox(height: 21),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      var prTitle = titleController.text;
                      var prDesp = despController.text;
        
                      if (prTitle.isNotEmpty && prDesp.isNotEmpty) {

                        if(updateDB){
                          context.read<DBProvider>().updateNote(sno, prTitle, prDesp);
                        }else{
                          context.read<DBProvider>().addNote(prTitle, prDesp);
                        }
                        // bool check = updateDB
                        //     ? await dbRef!.updateNotes(mTitle: prTitle, mDes: prDesp, srNo: sno)
                        //     : await dbRef!.addNotes(mTitle: prTitle, mDesp: prDesp);
        
                        // if (check) {
                        //   // getallNotes(); // Refresh notes after add/update
                          Navigator.pop(context);
                        // }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all fields"),
                        ));
                      }
        
                      // Close the bottom sheet using the BuildContext passed to the method
                      titleController.clear();
                      despController.clear();
                    },
                    child: Text(
                      updateDB ? "Update" : "Save",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    side: const BorderSide(width: 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
  
    );
  }
}