import 'package:shop_getx/repositories/dio_field.dart';

import '../models/Tag.dart';


class TagRepository{

  Future<Tag> addTag({required Tag newTag}) async{
    try{
      var response = await dioBaseUrl.post('tag', data: newTag.toJson());
      Tag retrievedTag = Tag.fromJson(response.data);
      return retrievedTag;
    }
    catch(e){
      print('add tag errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<List<Tag>>getTags() async{
    var response = await dioBaseUrl.get('tag');
    try {
      final tagResult = await response.data.map<Tag>((element) {
        return Tag.fromJson(element);
      }).toList();
      return tagResult;
    } catch (e) {
      print('****get tag error*****: ${e.toString()}');
      return throw e.toString();
    }
  }


  Future<Tag> editTag({required Tag targetTag}) async{
    try{
      var response = await dioBaseUrl.put('tag/${targetTag.id.toString()}', data: targetTag.toJson());
      Tag retrievedTag = Tag.fromJson(response.data);
      return retrievedTag;
    }
    catch(e){
      print('***edit tag error*** ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<Tag> deleteTag(
      {required Tag targetTag}) async {
    try {
      var response = await dioBaseUrl.delete('tag/${targetTag.id.toString()}',
          data: targetTag.toJson());
      Tag retrievedTag = Tag.fromJson(response.data);
      return retrievedTag;
    } catch (e) {
      print('***delete tag error*** ${e.toString()}');
      return throw e.toString();
    }
  }


}