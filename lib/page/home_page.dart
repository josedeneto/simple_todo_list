import 'package:flutter/material.dart';
import 'package:simple_todo_list/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _cTodo;
  final homeController = HomeController();
  @override
  void initState() {
    _cTodo = TextEditingController();
    super.initState();
    homeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Minhas tarefas',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Stack(
        children: [
          homeController.todo.isEmpty
              ? const Center(
                  child: Text('Nenhuma tarefa'),
                )
              : ListView.builder(
                  itemCount: homeController.todo.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Center(
                          child: Text(
                            homeController.todo[i][0].toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        homeController.todo[i],
                      ),
                    );
                  }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: const BoxDecoration(color: Colors.white30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cTodo,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Adicione uma tarefa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeController.addTodo(todo: _cTodo.text);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
