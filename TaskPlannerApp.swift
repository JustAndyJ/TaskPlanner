 
class ListItem {
   var task: String
   var next: ListItem?

   init(task: String) {
     self.task = task
     self.next = nil
   }
 }

func createStruckList() -> [[ListItem?]] {
  
   var calendar: [[ListItem?]] = Array(repeating: Array(repeating: nil, count: 0), count: 12)

  for i in 0..<12 {

    var nDays = 0
  switch i + 1  {

    case  1, 3, 5, 7, 8, 10, 12:
      nDays = 31
    case 4, 6, 9, 11:
        nDays = 30
    default:
        nDays = 28
  }
    for _ in 0..<nDays {
      calendar[i].append(nil)
    }
  }
  return calendar
}
func menu() {
  print("\nMenu of calendar:")
  print("\n    1. Add an task")
  print("    2. Remove an task")
  print("    3. Show all tasks")
  print("    4. Exit")

  print("\nEnter your choice en number : ", terminator: "")
  guard let choice = readLine() else {
    print("input error")
     return
  }
  switch choice {

    case "1":
      addTask()
    case "2":
      removeTask()
    case "3":
      showTasks()
    case "4":
      return
    default:
      return
  }
  menu() 
}

func addTask() {  
  
  print("\nEnter the mount 1 - 12 : ", terminator: "")
  guard let month = readLine(), let intMonth = Int(month) else {
    print("input error")
    return
  }
  print("Enter the day: ", terminator: "")
  guard let day = readLine(), let intDay = Int(day) else {
    print("input error")
    return
  }
   
  showTasks(intMonth, intDay)

  print("Enter the position: ", terminator: "")
  guard let post = readLine(), let intPost = Int(post) else {
    print("input error")
    return
  }
  
  print("Enter the task: ", terminator: "")
  guard let task = readLine() else {
    print("input error")
    return
  }

  inserElemtn(month: intMonth, day: intDay, tasks: task, position: intPost)

}

func removeTask() {
  
  showTasks()
  
  print("Enter the mount 1 - 12 to delete: ", terminator: "")
  guard let month = readLine(), let intMonth = Int(month) else {
    print("input error")
    return
  }
  print("Enter the day to delete: ", terminator: "")
  guard let day = readLine(), let intDay = Int(day) else {
    print("input error")
    return
  }
  print("\nEnter the position the task: ", terminator: "")
  guard let post = readLine(), let intPost = Int(post) else {
    print("input error")
    return
  }
  
  var head = calendarTask[intMonth - 1][intDay - 1]
   
  if intPost == 1 {
    head = head?.next
  } else {
    var item = head
    var index = intPost
    
    while index > 2 && item != nil {
      item = item?.next
      index -= 1
    }
    guard let lastItem = item?.next else {
      print("the positon exceeds the number of tasks")
      return
    }
      item?.next = lastItem.next 
    }
  
calendarTask[intMonth - 1][intDay - 1] = head

}


func showTasks(_ month: Int? = nil, _ day: Int? = nil) {

    if month == nil && day == nil {
          
          print("\nThe list complete: ")
          var empty = true
          for (indexMonth, month) in calendarTask.enumerated() { 
            
             for (indexDay, dayTask) in month.enumerated() {  
               
              
                if dayTask != nil {
                 empty = false
                 print("\n   month \(indexMonth + 1):")
                 print("   day \(indexDay + 1):")
                  
                  var item = dayTask
                  var i = 1

                  while item != nil {
                    print("      task \(i): \(item?.task ?? "NA")" )
                     item = item?.next
                    i+=1
                  } 
       
              }      
            } 
          }
      if empty {
        print("\nThe calendar is empty")
      }
      
    } else {
      
          let myDayTask = calendarTask[month! - 1][day! - 1]
          
          if myDayTask != nil {

           print("\n   month \(month!):")
           print("      day \(day!):")

            var item = myDayTask
            var i = 1

            while item != nil {
              print("\n  task \(i): \(item?.task ?? "NA")" )
               item = item?.next
              i+=1
            }         
      } else if myDayTask == nil && myDayTask?.next == nil {
            print("\nThere is no task for this day, enter the first task")
      }
  }
 
}

func inserElemtn(month: Int, day: Int, tasks: String, position: Int) {
  
    let listTask = ListItem(task: tasks)
    var head: ListItem?
    
    if calendarTask[month - 1][day - 1] != nil {
      head = calendarTask[month - 1][day - 1] 
    } else {
      head = nil
    }

    if position == 1 {
      
      listTask.next = head
      head = listTask
      
    } else {
      var item = head
      var index = position

      while index > 2 && item != nil {
        item = item?.next
        index -= 1
      }
       listTask.next = item?.next
       item?.next = listTask  
      }
    calendarTask[month - 1][day - 1] = head
  }

var calendarTask = createStruckList()
menu()
