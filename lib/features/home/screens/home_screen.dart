import 'package:flutter/material.dart';

import '/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoModel> todos = [
    TodoModel(
      id: '1',
      title: 'Flutter project',
      description: 'Work on Flutter project',
      isCompleted: false,
    ),
    TodoModel(
      id: '2',
      title: 'Grocery shopping',
      description: 'Buy groceries for the week',
      isCompleted: false,
    ),
  ];

  final List<TodoModel> done = [
    TodoModel(
      id: '3',
      title: 'Workout',
      description: 'Do a 30-minute workout',
      isCompleted: true,
    ),
    TodoModel(
      id: '4',
      title: 'Read book',
      description: 'Read 50 pages of a book',
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<TodoModel> allTodos = [...todos, ...done];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Todos'),
              Tab(text: 'Done'),
              Tab(text: 'All'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await getIt<IAuthService>().signOut();
              },
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            TodoListView(todos: todos),
            TodoListView(todos: done),
            TodoListView(todos: allTodos),
          ],
        ),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  final List<TodoModel> todos;

  const TodoListView({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width - 24,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    todo.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
