import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_architecture/features/users/presentation/user_list.dart';
import '../../../core/di/injector.dart';
import '../domain/entities/user.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(LoadUsers()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<UserBloc>().add(
              AddUserEvent(
                User(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: 'User ${DateTime.now().second}',
                ),
              ),
            );
          },
          label: const Text('Add User'),
          icon: const Icon(Icons.add),
        ),
        body: const UserList(),
      ),
    );
  }
}
