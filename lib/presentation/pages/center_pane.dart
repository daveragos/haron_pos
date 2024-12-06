import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CenterPane extends StatefulWidget {
  const CenterPane({super.key});

  @override
  State<CenterPane> createState() => _CenterPaneState();
}

class _CenterPaneState extends State<CenterPane> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String dropdownValue = 'Dine In';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HARON POS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(0, 0.5),
                            blurRadius: 0.5,
                          ),
                        ],
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      DateFormat('dd, MMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(0, 0.5),
                            blurRadius: 0.5,
                          ),
                        ],
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "   Search",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.orange,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Beverages'),
              Tab(text: 'Snacks'),
              Tab(text: 'Produce'),
              Tab(text: 'Dairy'),
              Tab(text: 'Bakery'),
              Tab(text: 'Frozen Foods'),
              Tab(text: 'Meat'),
              Tab(text: 'Seafood'),
              Tab(text: 'Other'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choose Dishes',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                DropdownButton<String>(
                  dropdownColor: Theme.of(context).primaryColor,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward, color: Colors.white),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Dine In', 'Delivery', 'To Go']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Scrollable grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4 / 3,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
