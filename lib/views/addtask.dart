import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controllers.dart';

import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {


  final TaskController taskController =Get.put(TaskController());
  final TextEditingController titleController =TextEditingController();
  final TextEditingController noteController =TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startTime =DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime =DateFormat('hh:mm a')
  .format(DateTime.now().add(const Duration( minutes: 15))).toString();
  int selectedRemind =5;
  List<int> remindList =[5,10,15,20];
  String selectedrepeat ='None';
  List<String> repeatList =['none','Daily','Weekly','Monthly'];
  int selectedColor = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child:   SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Task",style: headingStyle,),
               TextFieldd(
                label: 'title', 
                hint: 'enter title here',
                controller: titleController,),
              TextFieldd(
                label: 'Note', 
                hint: 'enter Note here',
                controller: noteController,),
              TextFieldd(
                label: 'Date', 
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  onPressed: (){}, 
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: kdarkClr,)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFieldd(
                    label: 'Start Time', 
                    hint: startTime,
                    widget: IconButton(
                    onPressed: (){}, 
                    icon: const Icon(
                      Icons.schedule_rounded,
                      color: kdarkClr,
                    )),
                  ),),
                  const SizedBox(width: 3,),
                  Expanded(
                    child: TextFieldd(
                    label: 'End Time', 
                    hint: endTime,
                    widget: IconButton(
                    onPressed: (){}, 
                    icon: const Icon(
                      Icons.schedule_rounded,
                      color: kdarkClr,
                    )),
                  ),),
                ],
              ),
              TextFieldd(
                    label: 'Remind', 
                    hint: '$selectedRemind minutes early',
                    widget: Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(15),
                        //dropdownColor: ,
                        items: remindList.map<DropdownMenuItem<String>>((value) => 
                        DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text('$value',
                          style: const TextStyle(color:kdarkClr ),))).toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color:kdarkClr,
                            size: 40,),
                            elevation: 4, 
                            underline: Container(height: 0),
                            style: supTitleStyle,
                        onChanged: (String? newValue){
                          setState(() {
                            selectedRemind = int.parse(newValue!);
                          });
                        }),
                    ),
              ),
              TextFieldd(
                    label: 'Repeat', 
                    hint: selectedrepeat,
                    widget: Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(15),
                        //dropdownColor: ,
                        items: repeatList.map<DropdownMenuItem<String>>((String value) => 
                        DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value,
                          style: const TextStyle(color:kdarkClr ),))).toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color:kdarkClr,
                            size: 40,),
                            elevation: 4, 
                            underline: Container(height: 0),
                            style: supTitleStyle,
                        onChanged: (String? newValue){
                          setState(() {
                            selectedrepeat = newValue!;
                          });
                        }),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    colorWidget(),   
                    UiButton(
                      label: 'Create Task', 
                      onTap: () { Get.back(); },),
              
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column colorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: titleStyle,),
        Wrap(
          children: List<Widget>.generate(3, 
          (index) => GestureDetector(
            onTap: (){
              setState(() {
                selectedColor = index;
              });
            },
            child:  Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: 
                index == 0? kdarkDo1 
                :index == 1? kdarkDo2 
                :kdarkDo3,
                child: selectedColor == index? const Icon(Icons.done) : null,
              ),
            ),
          ),))
        

      ],
    );
  }

  AppBar customAppBar(){
    return AppBar(
        backgroundColor: context.theme.primaryColor,
        centerTitle: true,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed:() => Get.back(),
        ),
        actions: const [
          CircleAvatar(
            radius: 19,
              backgroundImage: AssetImage("assets/images/businessman.png",
              ),
          ),
          SizedBox(width: 20,)

        ],
      );
  }


}

