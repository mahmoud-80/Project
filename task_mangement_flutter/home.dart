import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TaskManagementScreen(),
    );
  }
}

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text.trim());
        _taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: "Enter a task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      "No tasks added yet",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskText: _tasks[index],
                        onDelete: () => _deleteTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String taskText;
  final VoidCallback onDelete;

  const TaskItem({super.key, required this.taskText, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(taskText),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
