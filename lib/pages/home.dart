import 'package:flutter/material.dart';
import 'package:textform/models/food.dart';
import 'package:textform/models/subject.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  String? foodValue;
  late List<Food> foods;
  late List<Subject> subjects;
  late List<ListItem> dropdownItems = ListItem.getlistItem();
  late List<DropdownMenuItem<ListItem>> dropdownMenuItems;
  late ListItem _selectedItem;

  List selectedSubject = [];

  get listCheckboxSubjects => null;

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subjects = Subject.getSubject();
    dropdownMenuItems = createDropdownMenu(dropdownItems);
    _selectedItem = dropdownMenuItems[0].value!;
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenu(
      List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in dropdownItems) {
      items.add(
        DropdownMenuItem(
          child: Text(item.name!),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  username(),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  password(),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  radio(),
                  Text('Item Selected: $foodValue'),
                  checkbox(),
                  dropdown(),
                  Text(
                    'Item selected: ' + _selectedItem.name!,
                  ),
                  submit()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  DropdownButton<ListItem> dropdown() {
    return DropdownButton(
      value: _selectedItem,
      items: dropdownMenuItems,
      onChanged: (ListItem? value) {
        setState(() {
          _selectedItem = value as ListItem;
        });
      },
    );
  }

  Column checkbox() {
    return Column(
      children: createSubjectCheckbox(),
    );
  }

  Column radio() {
    return Column(
      children: createFoodradio(),
    );
  }

  TextFormField password() {
    return TextFormField(
      controller: _passwordcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Password';
        }
        return null;
      },
      obscureText: true,
      decoration: const InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ))),
    );
  }

  ElevatedButton submit() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          print(_usernamecontroller.text);
          print(_passwordcontroller.text);
        }
        return null;
      },
      child: Text('Submit'),
    );
  }

  TextFormField username() {
    return TextFormField(
      controller: _usernamecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Username';
        }
        return null;
      },
      // obscureText: true,
      decoration: const InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(Icons.person),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ))),
    );
  }

  List<Widget> createFoodradio() {
    List<Widget> listRadioFood = [];
    for (var food in foods) {
      listRadioFood.add(
        RadioListTile<dynamic>(
          title: Text(food.thName!),
          subtitle: Text(food.enName!),
          secondary: Text(food.Price!.toString() + 'BAHT'),
          value: food.foodvalue,
          groupValue: foodValue,
          onChanged: (value) {
            setState(() {
              foodValue = value.toString();
            });
          },
        ),
      );
    }
    return listRadioFood;
  }

  List<Widget> createSubjectCheckbox() {
    List<Widget> listCheckboxSubject = [];
    for (var subject in subjects) {
      listCheckboxSubject.add(
        CheckboxListTile(
          title: Text(subject.subName!),
          subtitle: Text('credit : ${subject.credit}'),
          value: subject.checked,
          onChanged: (value) {
            setState(() {
              subject.checked = value!;
            });
            if (value!) {
              selectedSubject.add(subject.subName!);
            } else {
              selectedSubject.remove(subject.subName!);
            }
            print(selectedSubject);
          },
        ),
      );
    }
    return listCheckboxSubject;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);
  static List<ListItem> getlistItem() {
    return [
      ListItem(1, 'Item 1'),
      ListItem(2, 'Item 2'),
      ListItem(3, 'Item 3'),
    ];
  }
}
