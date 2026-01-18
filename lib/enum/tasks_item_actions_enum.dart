enum TasksItemActionsEnum{
  markAsDone(name: "Done | Undone"),
  edit(name: "Edit"),
  delete(name: "Delete")
  ;




  final String name;
  const TasksItemActionsEnum({required this.name});
}