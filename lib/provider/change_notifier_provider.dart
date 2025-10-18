import 'package:flutter/material.dart';

class ChangeNotifierProvider<T extends ChangeNotifier>
    extends StatefulWidget {
  final T Function(BuildContext) create;
  final Widget Function(BuildContext, T, Widget?) builder;
  final Widget? child;

  const ChangeNotifierProvider({
    super.key,
    required this.create,
    required this.builder,
    this.child,
  });

  @override
  State<ChangeNotifierProvider> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  late T _provider;

  @override
  void initState() {
    super.initState();
    _provider = widget.create(context);
    _provider.addListener(_onNotify);
  }

  void _onNotify() {
    setState(() {});
  }

  @override
  void dispose() {
    _provider.removeListener(_onNotify);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _provider, widget.child);
  }
}

class Consumer<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext, T, Widget?) builder;
  final Widget? child;

  const Consumer({
    super.key,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.findAncestorStateOfType<
            _ChangeNotifierProviderState<T>>()
        ?._provider as T;
    return builder(context, provider, child);
  }
}