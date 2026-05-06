import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_http/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  _RemoteApiState createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserList() async {
    try {
      var response = await Dio().get(
        'https://jsonplaceholder.typicode.com/users',
      );
      List<UserModel> userList = [];
      if (response.statusCode == 200) {
        //200 başarili islem demek
        userList = (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      }
      return userList;
    } on DioException catch (e) {
      return Future.error(e.message ?? 'Bir hata oluştu');
    }
  }

  late final Future<List<UserModel>> _userList;
  @override
  void initState() {
    super.initState();
    _userList = _getUserList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Remote Api with Dio')), // AppBar
      body:  Center(
        child: FutureBuilder<List<UserModel>>(
          future: _userList,  //bu sayede modelin performansi daha iyi olur
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var userList = snapshot.data!;
              return ListView.builder(itemBuilder: (context, index){
                var user = userList[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.address.toString()),
                  leading: Text(user.id.toString()),
                );
              }, itemCount: userList.length);
            }else if (snapshot.hasError){
              return Text(snapshot.error.toString());
            }else{
              return const CircularProgressIndicator();
            }
          },
           ),
           ),
      ); // Center
  }
}
