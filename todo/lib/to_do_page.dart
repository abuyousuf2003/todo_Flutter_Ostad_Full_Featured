import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToDoPage extends StatefulWidget{
  State<ToDoPage> createState()=> _ToDoPageState();
}



class _ToDoPageState extends State<ToDoPage>{

List<Map<String,dynamic>> _taskAdded =[];
bool trueActive =true;
void taskStatus(int index)
{
_taskAdded[index]["completed"] = !_taskAdded[index]["completed"] ;
}

void taskAdd(String task)
{
setState(() {
  _taskAdded.add({
    "task":task,
    "completed":false
  });
});
}
int active ()
{
  return _taskAdded.where((e)=> !e["completed"]).length;

}
int completed ()
{
  return _taskAdded.where((e)=> e["completed"]).length;

}

void _showDialouge()
{
TextEditingController controller = TextEditingController();
showDialog(context: context, builder: (BuildContext context){
return Container(
  height: 300,
  width: 300,
  child: AlertDialog(
    title: Text("Add Task"),
    content: TextField(
controller: controller,
decoration: InputDecoration(

),
    ),
    actions: [
TextButton(onPressed: (){
Navigator.pop(context);

}, child: Text("cancel")),
ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(),
    backgroundColor: Colors.blue
  ),
  onPressed: (){
    String text = controller.text.toString();
   taskAdd(text);
   Navigator.pop(context);
   
  }, child: Text("Save",style: TextStyle(color: Colors.white),))
    ],
  ),
);
});
}


  @override
  Widget build(BuildContext context) {
   List<Map<String,dynamic>>  _filteredTask = _taskAdded.where((task)=>task["completed"] != trueActive).toList();

    int activeCount = active();
    int completedCount = completed();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue.shade300,
      title: Text("Todo App",),),
floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
  onPressed: (){
  _showDialouge();
}),
    body: SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
         
         
          children: [
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

InkWell(
                onTap: (){
                  setState(() {
                    trueActive =true;
                  });
                },
                 child: Container(
                    height: 75,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 156, 4)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                   Text("Active",style: TextStyle(fontSize: 24),),
                        Text(activeCount.toString(),style: TextStyle(fontSize: 24),),
                      ],
                    ),
                  ),
               ),




                
                //completed task
                InkWell(
                  onTap: (){
                    setState(() {
                      trueActive =false;
                    });
                  },
                  child: Container(
                    height: 75,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 102, 185, 6)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Completed",style: TextStyle(fontSize: 24),),
                     Text(completedCount.toString(), style: TextStyle(fontSize: 24),),
                      ],
                    ),
                  ),
                ),
                //Active task
               
              ],
            ),
            SizedBox(height:20),
Expanded(
  child: Container(
  
    child: ListView.builder(
      
      itemCount: _filteredTask.length,
      itemBuilder: (BuildContext,index){
  return Dismissible(key: Key(_taskAdded[index]["task"]), 

  //left to right
  background: Card(
    color: Colors.green,
    child: Icon(Icons.check_box_outlined),
  ),

  secondaryBackground: Card(
    color: Colors.red,
    child: Icon(Icons.delete),
  ),
  onDismissed: (direction){
    if(direction == DismissDirection.startToEnd){
      setState(() {
       taskStatus(index);
      });

      
    }

    else{
      setState(() {
       _taskAdded.removeAt(index);
      });
    }
  },
 
  
  child: Card(
  
    child: ListTile(
      title: Text(_filteredTask[index]["task"].toString()),
    ),
  ));
  
    }),
  ),
)

          ],




        ),
      ),
    ),
  );
  }
}


// final GlobalKey<_ToDoPageState> floatingElement = GlobalKey<_ToDoPageState>();
