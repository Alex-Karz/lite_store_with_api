import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users_model.dart';
import '../services/api_handler.dart';
import '../widgets/users_widget.dart';


class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
        ),
        body: FutureBuilder<List<UsersModel>>(
          future: APIHandler.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('An error occurred - ${snapshot.error}'),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text('No products has been added yet'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(value: snapshot.data![index], child: const UsersWidget());
              },
              itemCount: snapshot.data!.length,
            );
          },
        ));
  }
}
