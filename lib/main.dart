import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Different Platform Adapter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLargeScreen = false;
  int selcetedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (MediaQuery.of(context).size.width > 600) {
              isLargeScreen = true;
            } else {
              isLargeScreen = false;
            }
            // return isLargeScreen
            //     ? Row(
            //         children: [
            //           ListWidget(
            //             itemCount: 10,
            //             itemSelctedCallBack: (value) {
            //               selcetedValue = value;
            //               setState(() {});
            //             },
            //           ),
            //           Expanded(
            //               child: DetailWidget(
            //             value: selcetedValue,
            //           ))
            //         ],
            //       )
            //     : ListWidget(
            //         itemCount: 20,
            //         itemSelctedCallBack: (value) {
            //           Navigator.of(context).push(MaterialPageRoute(builder:(context) {
            //             return DetailWidget(value: selcetedValue);
            //           },));
            //         },
            //       );
            return Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ListWidget(
                      itemCount: 10,
                      itemSelctedCallBack: (value) {
                        if (isLargeScreen) {
                          selcetedValue = value;
                          setState(() {});
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return DetailWidget(value: value);
                            },
                          ));
                        }
                      },
                    )),
                isLargeScreen
                    ? Expanded(
                        flex: 2, child: DetailWidget(value: selcetedValue))
                    : Container()
              ],
            );
          },
        ));
  }
}

typedef ItemSelctedCallBack = Null Function(int value);

class ListWidget extends StatelessWidget {
  final int itemCount;

  final ItemSelctedCallBack itemSelctedCallBack;

  const ListWidget(
      {Key? key, required this.itemCount, required this.itemSelctedCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            itemSelctedCallBack(index);
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(20),
            color: Colors.pink[100],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                index.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
      itemCount: itemCount,
    );
  }
}

class DetailWidget extends StatelessWidget {
  final int value;

  const DetailWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
