import 'package:flutter/material.dart';
import 'package:pardemo/modal/emp_modal.dart';
import 'package:pardemo/modal/emplist_model.dart';
import 'package:pardemo/modal/user_model.dart';
import 'package:pardemo/pages/detail_page.dart';
import 'package:pardemo/services/http_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> items = new List();

  void _apiEmpList() {
    Network.GET(Network.API_EMP_LIST, Network.paramsEmpty()).then((response) => {
      print(response),
      _showResponse(response),
    });
  }

  void _apiEmpOne(int id) {
    Network.GET(Network.API_EMP_ONE + id.toString(), Network.paramsEmpty()).then((response) => {
      print(response),
      _showResponse(response),
    });
  }

  void _apiEmpCreate(User user) {
    Network.POST(Network.API_EMP_CREATE, Network.paramsCreate(user)).then((response) => {
      print(response),
      _showResponse(response),
    });
  }

  void _apiEmpUpdate(User user) {
    Network.PUT(Network.API_EMP_UPDATE + user.id.toString(), Network.paramsUpdate(user)).then((response) => {
      print(response),
      _showResponse(response),
    });
  }

  void _apiEmpDelete(User user){
    Network.DEL(Network.API_EMP_DELETE + user.id.toString(), Network.paramsEmpty()).then((response) => {
      print(response),
      _showResponse(response),
    });
  }

  void _showResponse(String response) {
    EmpList empList = Network.parseEmpList(response);
    setState(() {
      items = empList.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var user = User(id: 1);
    _apiEmpList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Employee List"),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
        },
      ),
    );
  }

  Widget itemOfList(Employee emp) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context, DetailPage.id);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emp.employee_name+"("+emp.employee_age.toString()+")",style: TextStyle(color: Colors.black,fontSize: 20),),
            SizedBox(height: 10,),
            Text(emp.employee_salary.toString()+"\$",style: TextStyle(color: Colors.black,fontSize: 18),),
          ],
        ),
      ),
    );
  }
}