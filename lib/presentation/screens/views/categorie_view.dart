import 'package:flutter/material.dart';

class CategorieView extends StatefulWidget {
  const CategorieView({super.key});

  @override
  State<CategorieView> createState() => _CategorieViewState();
}

class _CategorieViewState extends State<CategorieView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Placeholder();
  }
  
  @override
  bool get wantKeepAlive => true;
}