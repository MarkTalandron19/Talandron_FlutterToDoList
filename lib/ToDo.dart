class ToDo{
  ToDo({required this.item, required this.finish});
  final String item;
  bool finish;

  String getItem()
  {
    return item;
  }

  bool getFinish() 
  {
    return finish;
  }

  void setFinish()
  {
    finish = !finish;
  }
}