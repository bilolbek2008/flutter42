import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllaers/plans_controller.dart';
import '../../models/plan.dart';

class PlanView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rejalar"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      labelText: "Reja nomi",
                      suffixIcon: IconButton(
                        onPressed: () {
                          final value = _controller.text;
                          if (value.isNotEmpty) {
                            Provider.of<PlanController>(context, listen: false)
                                .addPlan(value);
                            _controller.clear();
                          }
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<PlanController>(
              builder: (context, controller, child) {
                final completedCount = controller.plans
                    .where((plan) => plan.isCompleted)
                    .length;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      "Bajarilgan rejalar: $completedCount, Bajarilmagan rejalar: ${controller.plans.length - completedCount}",
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<PlanController>(
              builder: (context, controller, child) {
                return ListView.builder(
                  itemCount: controller.plans.length,
                  itemBuilder: (context, index) {
                    final plan = controller.plans[index];
                    return ListTile(
                      title: Text(plan.title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, controller, index, plan);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.removePlan(index);
                            },
                          ),
                          Checkbox(
                            value: plan.isCompleted,
                            onChanged: (_) {
                              controller.togglePlanCompletion(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, PlanController controller, int index, Plan plan) {
    final TextEditingController editController = TextEditingController(text: plan.title);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit qismi"),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: "Rejani eski nomi",
            ),
          ),
          actions: [
            TextButton(
              child: Text("cansel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("save"),
              onPressed: () {
                final newValue = editController.text;
                if (newValue.isNotEmpty || newValue == null) {
                  controller.updatePlan(index, newValue);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
