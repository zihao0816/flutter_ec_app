import 'dart:convert';

import '../pluginPachaging/Storage.dart';
class StorageData{
  static setData(value) async{
    try{
      var searchData = json.decode(await Storage.getString('searchList'));
      var hastrue = searchData.any((v){
                      return v==value;
                    });
          if(!hastrue){
            searchData.add(value);
            await Storage.setString('searchList', json.encode(searchData));
          }

    }catch(e){
        List list = List();
        list.add(value);
        await Storage.setString('searchList', json.encode(list));
    }
    
  }
  static getData() async{
    try{
      List searchData = json.decode(await Storage.getString('searchList'));
      return searchData;
    }catch(e){
        return [];
    }
  }
  static removeData(key) async{
     List searchData = json.decode(await Storage.getString('searchList'));
     searchData.remove(key);
     await Storage.setString('searchList', json.encode(searchData));
  }
  static clearData() async{
     await Storage.remove('searchList');
  }
}
