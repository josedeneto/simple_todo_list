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
  final GlobalKey<FormState> _formKey = GlobalKey();
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
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(color: Colors.white30),
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Introduza uma tarefa';
                          }
                          return null;
                        }),
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
                        if (_formKey.currentState!.validate()) {
                          homeController.addTodo(todo: _cTodo.text);
                          _cTodo.clear();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                        ),
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
            ),
          )
        ],
      ),
    );
  }
}
