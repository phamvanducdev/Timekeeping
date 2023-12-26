import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';
import 'package:timekeeping/features/home/home_vm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      context.read<ApiRepository>(),
    );
    _viewModel.initialize(
      onLogin: () => context.go('/auth'),
      onFailed: (String message) {
        // Dialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Text('HomeScreen'),
        ),
      ),
    );
  }
}
