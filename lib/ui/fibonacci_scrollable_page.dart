import 'package:flutter/material.dart';
import 'package:mobile_assignment_flutter/model/fibonacci_model.dart';

import '../util.dart';
import 'dialog/bottom_sheet_show_fibo_by_type.dart';
import 'dialog/popup_about_me.dart';

class FibonacciScrollablePage extends StatefulWidget {
  const FibonacciScrollablePage({super.key});

  @override
  State<FibonacciScrollablePage> createState() => _FibonacciScrollablePageState();
}

class _FibonacciScrollablePageState extends State<FibonacciScrollablePage> {
  final double itemHeight = 55;
  final ScrollController _scrollController = ScrollController();
  Fibonacci? highlightedItem;

  late List<Fibonacci> fibonacciList;
  List<Fibonacci> cross = [];
  List<Fibonacci> square = [];
  List<Fibonacci> circle = [];

  @override
  void initState() {
    super.initState();
    fibonacciList = generateFibonacciList(41);
  }

  void onTapListTile(Fibonacci fibo) {
    setState(() {
      final typeMap = {
        FibonacciType.circle: circle,
        FibonacciType.square: square,
        FibonacciType.cross: cross,
      };

      typeMap[fibo.type]?.add(fibo);
      showModalBottomSheetFiboByType(typeMap[fibo.type]!, fibo.index).then((v) {
        if (v != null) {
          setState(() {
            typeMap[fibo.type]?.clear();
            typeMap[fibo.type]?.addAll(v.$2);

            final filtered = fibonacciList.where((e) => e.show).toList();
            final index = filtered.indexWhere((e) => e.index == v.$1.index);
            if (index != -1) {
              highlightedItem = filtered[index];
              _scrollController.animateTo(
                (index - 3) * (itemHeight),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          });
        }
      });

      fibonacciList[fibo.index].show = false;
    });
  }

  Future<(Fibonacci, List<Fibonacci>)?> showModalBottomSheetFiboByType(List<Fibonacci> list, int focusIndex) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: BottomSheetShowFiboByType(list: list, focusIndex: focusIndex),
      ),
    ).then((value) {
      if (value is (Fibonacci, List<Fibonacci>)) {
        final fibo = value.$1;
        setState(() {
          fibonacciList[fibo.index].show = true;
        });
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = fibonacciList.where((e) => e.show).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text("Example"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => PopupAboutMe());
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: Center(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: filtered.length,
          itemBuilder: (context, i) {
            final item = filtered[i];
            return SizedBox(
              height: itemHeight,
              child: ListTile(
                splashColor: Colors.transparent,
                onTap: () => onTapListTile(item),
                tileColor: highlightedItem?.index == item.index ? Colors.red : null,
                title: Row(
                  spacing: 8,
                  children: [
                    Text("Index: ${item.index}"),
                    Text("Number: ${item.number}"),
                  ],
                ),
                trailing: Fibonacci.getIconByType(item.type),
              ),
            );
          },
        ),
      ),
    );
  }
}
