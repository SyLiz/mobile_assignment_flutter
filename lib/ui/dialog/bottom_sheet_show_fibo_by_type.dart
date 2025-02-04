import 'package:flutter/material.dart';
import 'package:mobile_assignment_flutter/model/fibonacci_model.dart';

class BottomSheetShowFiboByType extends StatefulWidget {
  final List<Fibonacci> list;
  final int focusIndex;
  const BottomSheetShowFiboByType({super.key, required this.list, required this.focusIndex});

  @override
  State<BottomSheetShowFiboByType> createState() => _BottomSheetShowFiboByTypeState();
}

class _BottomSheetShowFiboByTypeState extends State<BottomSheetShowFiboByType> {
  final double itemHeight = 50;
  final ScrollController _scrollController = ScrollController();
  List<Fibonacci> sortedList = [];
  @override
  void initState() {
    super.initState();
    widget.list.sort((a, b) => a.index.compareTo(b.index));
    sortedList = widget.list;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = sortedList.indexWhere((e) => e.index == widget.focusIndex);
      if (index != -1) {
        _scrollController.animateTo(
          index * itemHeight,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      child: Material(
        child: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
              controller: _scrollController,
              itemCount: sortedList.length,
              itemBuilder: (context, i) {
                final item = sortedList[i];
                return ListTile(
                  tileColor: widget.focusIndex == item.index ? Colors.green : null,
                  onTap: () {
                    final tempList = sortedList.where((e) => e.index != item.index);
                    Navigator.pop(context, (item, tempList.toList()));
                  },
                  title: SizedBox(
                    height: itemHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Number: ${item.number}"),
                        Text(
                          "Index: ${item.index}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  trailing: Fibonacci.getIconByType(item.type),
                );
              }),
        ),
      ),
    );
  }
}
