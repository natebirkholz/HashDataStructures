
import Swift

extension String {
  func hash(size: Int) -> Int {
    var total = 0
    var scalars = self.unicodeScalars
    for scalar in scalars{
      total = total + Int(scalar.value)
    }
    total = total * countElements(self)
    let returnValue = total % size
    return returnValue
  }
}

class LinkedList : Printable {
  
  class Node {
    
    var next : Node?
    var value : String
    
    init(value: String){
      self.value = value
    }
    
  }
  
  var first : Node?
  var description : String {
    
    if first == nil {
      return "List is empty."
    } else if first!.next == nil {
      return "List has one node : \(first!.value)"
    } else {
      var number = 1
      var array = "\(first!.value)"
      var node = first
      while node!.next != nil{
        array = array + " -> " + node!.next!.value
        number += 1
        node = node!.next
      }
      return "List has \(number) nodes : \(array)"
    }
    
  }
  
  func addObject(value: String) {
    if first == nil {
      first = Node(value: value)
    } else if first!.next == nil {
      first!.next = Node(value: value)
    } else {
      var node = first
      while node!.next != nil{
        node = node!.next
      }
      node!.next = Node(value: value)
    }
  }
  
  func findObject(value : String) -> Node? {
    if first == nil {
      return nil
    }
    
    if first?.value == value {
      return first
    }
    
    var node = first
    while node!.next != nil {
      node = node!.next
      if node!.value == value {
        return node
      }
    }
    return nil
  }
  
  func removeObject(value: String) -> String? {
    if first == nil {
      return nil
    }
    
    if first!.value == value {
      let value = first!.value
      first = first!.next
      return value
    }
    
    var previousNode : Node?
    var node = first
    while node!.next != nil {
      previousNode = node
      node = node!.next
      if node!.value == value {
        let value = node!.value
        previousNode!.next = node!.next
        return value
      }
    }
    return nil
  }

  func addToFrontOfStack(value: String) {
    var nodeFor: Node?
    if first == nil {
      first = Node(value: value)
    } else {
      nodeFor = first
      first = Node(value: value)
      first!.next = nodeFor
    }
  }

}

class HashTable {

  var array = [LinkedList]()
  var size = 100
  var usedSize = 0
  var usedThreshold : Double {
    return Double(size) * 0.7
  }
  
  init() {
    self.populateWithLinkedLists()
  }
  
  private func populateWithLinkedLists(){
    for i in 0...size {
      array.append(LinkedList())
    }
  }
  
  func findHash(object: String) -> Int{
    let index = object.hash(size)
    println(index)
    return index
  }

  func addObject(object: String) {
    array[findHash(object)].addObject(object)
    if Double(usedSize) > usedThreshold {
      resizeTable()
    }
  }
  
  func findObject(object: String) {
    array[findHash(object)].findObject(object)
  }
  
  func removeObject(object: String) {
    array[findHash(object)].removeObject(object)
  }
  
  func resizeTable(){
    let tempList = LinkedList()
    for list in array {
      while list.first != nil {
        tempList.addObject(list.removeObject(list.first!.value)!)
      }
    }
    self.size = self.size * 2
    populateWithLinkedLists()
    while tempList.first != nil {
      self.addObject(tempList.removeObject(tempList.first!.value)!)
    }
  }
}

class Stack {
  var stackList = LinkedList()

  func push(value: String) {
    stackList.addToFrontOfStack(value)
  }

  func pop() -> String? {
    if stackList.first == nil {
        return nil
    } else {
      let valueFor = stackList.first?.value
      stackList.removeObject(stackList.first!.value)
      return valueFor
    }
  }

}

class Queue {
  var queueList = LinkedList()

  func enQueue(value: String) {
    queueList.addObject(value)
  }

  func deQueue() -> String? {
    if queueList.first == nil {
      return nil
    } else {
      let valueFor = queueList.first?.value
      queueList.removeObject(queueList.first!.value)
      return valueFor
    }
  }

}


var hashTable = HashTable()
hashTable.addObject("Hello")
hashTable.addObject("World")
hashTable.addObject("Pasta")
hashTable.addObject("Potato")
hashTable.addObject("Franklin")
hashTable.addObject("Dog")
hashTable.addObject("Spaceship")
hashTable.addObject("Fart")

var myStack = Stack()
myStack.push("one")
myStack.push("two")
myStack.push("three")
myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()

var myQueue =  Queue()
myQueue.enQueue("one")
myQueue.enQueue("two")
myQueue.enQueue("three")
myQueue.deQueue()
myQueue.deQueue()
myQueue.deQueue()
myQueue.deQueue()





