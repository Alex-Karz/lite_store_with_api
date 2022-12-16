import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users_model.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersModel>(context);

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          usersProvider.avatar.toString(),
        ),
      ),
      title: Text(usersProvider.name.toString()),
      subtitle: Text(usersProvider.email.toString()),
      trailing: Text(usersProvider.role.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red)),
    );
  }
}
