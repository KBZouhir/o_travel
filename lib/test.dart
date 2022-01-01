import 'package:flutter/material.dart';
import 'package:o_travel/Models/User.dart';
import 'package:select_dialog/select_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? ex1;
  String? ex2;
  User? ex3;
  User? ex4;
  List<String> ex5 = [];
  String? ex6;
  final ex6Controller = TextEditingController(text: "20");

  final modelItems = List.generate(
    50,
        (index) =>User(
      image: "https://i.imgur.com/lTy4hiN.jpg",
      name: "Deivão $index",
      email: "Deivão $index",
      phone: "Deivão $index",
      countryCode:  "Deivão $index",
      state:  "Deivão $index",
      id: index
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Dialog Example")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text(ex1 ?? "Simple Example"),
                onPressed: () {
                  SelectDialog.showModal<String>(
                    context,
                    label: "Simple Example",
                    titleStyle: TextStyle(color: Colors.brown),
                    selectedValue: ex1,
                    backgroundColor: Colors.amber,
                    items: List.generate(50, (index) => "Item $index"),
                    onChange: (String selected) {
                      setState(() {
                        ex1 = selected;
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text(ex2 ?? "Model Example"),
                onPressed: () {
                  SelectDialog.showModal<User>(
                    context,
                    alwaysShowScrollBar: true,
                    label: "Model Example",
                    searchBoxDecoration: InputDecoration(hintText: "Example Hint"),
                    items: modelItems,
                    onChange: (User selected) {
                      setState(() {
                        ex2 = selected.name;
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text(ex3?.name ?? "Item Builder Example"),
                onPressed: () {
                  SelectDialog.showModal<User>(
                    context,
                    label: "Item Builder Example",
                    items: modelItems,
                    selectedValue: ex3,
                    itemBuilder: (BuildContext context, User item, bool isSelected) {
                      return Container(
                        decoration: !isSelected
                            ? null
                            : BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(backgroundImage: item.image == null ? null : NetworkImage(item.image!)),
                          selected: isSelected,
                          title: Text(item.name),
                          subtitle: Text(item.phone.toString()),
                        ),
                      );
                    },
                    onChange: (selected) {
                      setState(() {
                        ex3 = selected;
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text(ex4?.name ?? "Online Example"),
                onPressed: () {
                  SelectDialog.showModal<User>(
                    context,
                    label: "Online Example",
                    selectedValue: ex4,
                    onFind: (String filter) => getData(filter),
                    onChange: (User selected) {
                      setState(() {
                        ex4 = selected;
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text(
                  ex5.isEmpty ? "Multiple Items Example" : ex5.join(", "),
                ),
                onPressed: () {
                  SelectDialog.showModal<String>(
                    context,
                    label: "Multiple Items Example",
                    multipleSelectedValues: ex5,
                    items: List.generate(50, (index) => "Item $index"),
                    itemBuilder: (context, item, isSelected) {
                      return ListTile(
                        trailing: isSelected ? Icon(Icons.check) : null,
                        title: Text(item),
                        selected: isSelected,
                      );
                    },
                    onMultipleItemsChange: (List<String> selected) {
                      setState(() {
                        ex5 = selected;
                      });
                    },
                    okButtonBuilder: (context, onPressed) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          onPressed: onPressed,
                          child: Icon(Icons.check),
                          mini: true,
                        ),
                      );
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text(ex6 ?? "Find Controller Example"),
                onPressed: () {
                  SelectDialog.showModal<User>(
                    context,
                    findController: ex6Controller,
                    alwaysShowScrollBar: true,
                    label: "Scroll Controller Example",
                    searchBoxDecoration: InputDecoration(hintText: "Example Hint"),
                    items: modelItems,
                    onChange: (User selected) {
                      setState(() {
                        ex6 = selected.name;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Future<List<User>> getData(String filter) async {
    var response = await Dio().get(
      "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
      queryParameters: {
        "filter": filter
      },
    );

    var models = User.fromJsonList(response.data);
    return models;
  }*/
}