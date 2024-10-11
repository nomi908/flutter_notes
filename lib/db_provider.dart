import 'package:flutter/material.dart';
import 'package:notes_app/data/local_data/dbhelper.dart';

class DBProvider extends ChangeNotifier{
  DBHelper dhelper;

  List<Map<String, dynamic>> _mdata = [];

  DBProvider({required this.dhelper});

  void addNote(String title, String desp)async{
   bool check = await dhelper.addNotes(mTitle: title, mDesp: desp);

   if(check){
    _mdata = await dhelper.getallNotes();
    notifyListeners();
   }

  }

  List<Map<String, dynamic>> getNotes() => _mdata;

  void initNotesget() async {
     _mdata = await dhelper.getallNotes();
    notifyListeners();
  }

  void updateNote(int sno, String title, String desp) async{
    bool update = await dhelper.updateNotes(mTitle: title, mDes: desp, srNo: sno);

    if(update){
      _mdata = await dhelper.getallNotes();
      notifyListeners();
    }
  }


  Future<void> deleteNote(int sno ) async {
    bool delete = await dhelper.deleteNotes(sno: sno);

    if(delete){
      _mdata = await dhelper.getallNotes();
      notifyListeners();
    }
  }


}